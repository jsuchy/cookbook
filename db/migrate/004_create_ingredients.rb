class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.column :recipe_id,    :integer
      t.column :position,     :integer
      t.column :quantity,     :decimal, :precision => 6, :scale => 2
      t.column :uom,          :string
      t.column :description,  :string
    end
  end

  def self.down
    drop_table :ingredients
  end
end
