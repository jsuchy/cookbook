class RenameTagsToClassifications < ActiveRecord::Migration
  def self.up
    drop_table :recipes_tags
    drop_table :tags

    create_table :classifications do |t|
      t.column :name, :string
    end

    create_table :classifications_recipes, :id => false do |t|
      t.column :recipe_id,  :integer
      t.column :classification_id,     :integer
    end
  end

  def self.down
    drop_table :classifications_recipes
    drop_table :classifications

    create_table :tags do |t|
      t.column :name, :string
    end

    create_table :recipes_tags, :id => false do |t|
      t.column :recipe_id,  :integer
      t.column :tag_id,     :integer
    end
  end
end
