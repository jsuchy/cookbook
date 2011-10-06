require "float"

class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  def self.parse(str, recipe)
    result = Ingredient.new(:recipe_id => recipe.id, :quantity => 0)
    IngredientParser.new(str, result).parse
  end

  def display_string
    display = [quantity_as_fraction, uom, ingredient].compact.join(" ")
    display << ", #{instruction}" unless instruction.blank?
    display
  end

  def quantity_as_fraction
    the_quantity = self.quantity.to_i == 0 ? "" : "#{self.quantity.to_i} "
    the_quantity << fractional_part_of_quantity_as_fraction if fractional_part_of_quantity > 0
    return the_quantity.strip
  end

  def fractional_part_of_quantity
    return self.quantity - self.quantity.to_i
  end

  def fractional_part_of_quantity_as_fraction
    the_fraction = fractional_part_of_quantity.to_fraction
    return "#{the_fraction[0]}/#{the_fraction[1]}"
  end

end
