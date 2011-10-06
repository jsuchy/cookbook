class AddTimestamps < ActiveRecord::Migration
  def self.up
    add_timestamps :ingredients
    add_timestamps :recipe_ingredients
    add_timestamps :recipes
  end

  def self.down
    remove_timestamps :ingredients
    remove_timestamps :recipe_ingredients
    remove_timestamps :recipes
  end
end
