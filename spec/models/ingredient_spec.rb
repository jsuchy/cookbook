require 'spec_helper'

describe Ingredient do

  it { should belong_to(:recipe) }

  describe "display" do

    it "displays basic ingredient" do
      ingredient = Ingredient.new(:quantity => "3", :uom => "cups", :ingredient => "cream")

      ingredient.display_string.should == "3 cups cream"
    end

    it "displays instructions" do
      ingredient = Ingredient.new(:quantity => "2", :ingredient => "large eggs", :instruction => "beaten")

      ingredient.display_string.should == "2 large eggs, beaten"
    end

    it "displays fractional quantity" do
      ingredient = Ingredient.new(:quantity => "1.5", :uom => "cups", :ingredient => "cream")

      ingredient.display_string.should == "1 1/2 cups cream"
    end

    it "displays 1/4 quantity" do
      ingredient = Ingredient.new(:quantity => "3.25", :uom => "cups", :ingredient => "cream")

      ingredient.display_string.should == "3 1/4 cups cream"
    end

    it "displays 3/4 quantity" do
      ingredient = Ingredient.new(:quantity => "0.75", :uom => "cups", :ingredient => "cream")

      ingredient.display_string.should == "3/4 cups cream"
    end

    it "calculates fraction" do
      check_fraction("0.125", "1/8")
      check_fraction("0.25", "1/4")
      check_fraction("0.375", "3/8")
      check_fraction("0.5", "1/2")
      check_fraction("0.625", "5/8")
      check_fraction("0.75", "3/4")
      check_fraction("0.875", "7/8")
    end

    def check_fraction(decimal, fraction)
      ingredient = Ingredient.new(:quantity => decimal)

      ingredient.fractional_part_of_quantity_as_fraction.should == fraction
    end

  end

  describe "parse" do

    before(:each) do
      @recipe = Recipe.create!(:title => "test recipe for ingredients")
    end

    it "associates the parsed ingredient with recipe" do
      ingredient = Ingredient.parse("2 cups carrots", @recipe)

      ingredient.recipe.id.should == @recipe.id
    end

    it "parses basic ingredient string" do
      expected = Ingredient.new(:quantity => 2, :uom => "cups", :ingredient => "carrots", :instruction => "diced")

      actual = Ingredient.parse("2 cups carrots, diced", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    it "parses ingredient without instruction" do
      expected = Ingredient.new(:quantity => 3, :uom => "cups", :ingredient => "peas")

      actual = Ingredient.parse("3 cups peas", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    it "parses ingredient without the unit" do
      expected = Ingredient.new(:quantity => 1, :ingredient => "carrot", :instruction => "diced")

      actual = Ingredient.parse("1 carrot, diced", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    it "parses singular unit" do
      expected = Ingredient.new(:quantity => 1, :uom => "cups", :ingredient => "carrots")

      actual = Ingredient.parse("1 cup carrots", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    it "parses decimal numbers" do
      expected = Ingredient.new(:quantity => 2.5, :ingredient => "carrots", :instruction => "diced")

      actual = Ingredient.parse("2.5 carrots, diced", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    it "parses fractions" do
      expected = Ingredient.new(:quantity => 0.5, :ingredient => "carrots", :instruction => "diced")

      actual = Ingredient.parse("1/2 carrots, diced", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    it "parses improper fractions" do
      expected = Ingredient.new(:quantity => 1.5, :ingredient => "carrots", :instruction => "diced")

      actual = Ingredient.parse("1 1/2 carrots, diced", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    it "parses multiple ingredient words" do
      expected = Ingredient.new(:quantity => 2, :uom => "cups", :ingredient => "whole milk", :instruction => "chilled")

      actual = Ingredient.parse("2 cups whole milk, chilled", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    it "parses multiple instruction words" do
      expected = Ingredient.new(:quantity => 3, :ingredient => "eggs", :instruction => "separated and whipped")

      actual = Ingredient.parse("3 eggs, separated and whipped", @recipe)

      assert_ingredients_equal(actual, expected)
    end

    def assert_ingredients_equal(actual, expected)
      actual.quantity.should == expected.quantity
      actual.uom.should == expected.uom
      actual.ingredient.should == expected.ingredient
      actual.instruction.to_s.should == expected.instruction.to_s
    end

  end


end
