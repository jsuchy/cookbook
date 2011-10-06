class RedefineIngredients < ActiveRecord::Migration
  def self.up
    drop_table :ingredients
    drop_table :recipe_ingredients

    create_table :ingredients do |t|
      t.column :recipe_id, :integer
      t.column :order_of, :integer
      t.column :quantity, :float
      t.column :uom, :string
      t.column :ingredient, :string
      t.column :instruction, :string
      t.timestamps
    end

  end

  def self.down
    drop_table :ingredients

    create_table :ingredients do |t|
      t.column :name, :string
      t.timestamps
    end

    create_table :recipe_ingredients do |t|
      t.column :recipe_id, :integer
      t.column :ingredient_id, :integer
      t.column :quantity, :float
      t.column :uom, :string
      t.column :position, :integer
      t.timestamps
    end

  end
end
