require 'spec_helper'

describe Recipe do
  before(:each) do
    @recipe = Recipe.new
  end

  it "knows if it is associated with specified user" do
    @recipe.user_id = 12

    @recipe.belongs_to_user?(12).should be_true
    @recipe.belongs_to_user?("12").should be_true
    @recipe.belongs_to_user?(13).should be_false
  end

  it "has searchable fields" do
    Recipe.searchable_fields.size.should == 3
    Recipe.searchable_fields.should include("title")
    Recipe.searchable_fields.should include("preparation")
    Recipe.searchable_fields.should include("source")
  end

  it "generates search clause" do
    Recipe.stub!(:searchable_fields).and_return(["field1", "field2"])

    Recipe.search_clause.should == "field1 LIKE ? OR field2 LIKE ?"
  end
end
