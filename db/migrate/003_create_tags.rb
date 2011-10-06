class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
    end

    create_table :recipes_tags, :id => false do |t|
      t.column :recipe_id,  :integer
      t.column :tag_id,     :integer
    end
  end

  def self.down
    drop_table :recipes_tags
    drop_table :tags
  end
end
