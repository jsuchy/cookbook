class CreateRecipesIngredients < ActiveRecord::Migration
  def self.up
    remove_column :ingredients, :recipe_id
    remove_column :ingredients, :quantity
    remove_column :ingredients, :position

    create_table :recipe_ingredients do |t|
      t.column :ingredient_id, :integer
      t.column :recipe_id,     :integer
      t.column :position,      :integer
      t.column :quantity,      :decimal, :precision => 6, :scale => 2
    end
  end

  def self.down
    drop_table :recipe_ingredients

    add_column :ingredients, :recipe_id, :integer
    add_column :ingredients, :quantity, :decimal, :precision => 6, :scale => 2
    add_column :ingredients, :position, :integer
  end
end
