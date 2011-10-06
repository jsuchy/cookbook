class AddIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :ingredients
  end
end
