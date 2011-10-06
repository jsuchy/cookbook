class RemoveCruft < ActiveRecord::Migration
  def self.up
    drop_table :recipe_ingredients
    drop_table :classifications_recipes
    drop_table :classifications
    drop_table :ingredients
    drop_table :categories
  end

  def self.down
    create_table :categories do |t|
      t.column :name, :string
    end

    create_table :ingredients do |t|
      t.column :uom,          :string
      t.column :description,  :string
    end

    create_table :classifications do |t|
      t.column :name, :string
    end

    create_table :classifications_recipes, :id => false do |t|
      t.column :recipe_id,  :integer
      t.column :classification_id,     :integer
    end

    create_table :recipe_ingredients do |t|
      t.column :ingredient_id, :integer
      t.column :recipe_id,     :integer
      t.column :position,      :integer
      t.column :quantity,      :decimal, :precision => 6, :scale => 2
    end
  end
end
