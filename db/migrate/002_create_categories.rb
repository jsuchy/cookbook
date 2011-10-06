class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :name, :string
    end

    add_column :recipes, :category_id, :integer
  end

  def self.down
    drop_table    :categories
    remove_column :recipes, :category_id
  end
end
