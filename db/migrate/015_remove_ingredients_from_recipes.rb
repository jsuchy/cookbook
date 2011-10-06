class RemoveIngredientsFromRecipes < ActiveRecord::Migration
  def self.up
    remove_column :recipes, :ingredients
  end

  def self.down
    add_column :recipes, :ingredients, :text
  end
end
