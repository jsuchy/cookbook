class CreateRecipeIngredients < ActiveRecord::Migration
  def self.up
    create_table :recipe_ingredients do |t|
      t.column :recipe_id, :integer
      t.column :ingredient_id, :integer
      t.column :quantity, :float
      t.column :uom, :string
      t.column :position, :integer
    end
  end

  def self.down
    drop_table :recipe_ingredients
  end
end
