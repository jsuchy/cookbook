class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.column :title,              :string
      t.column :bake_temperature,   :integer, :default => 350
      t.column :prep_time,          :integer, :default => 0
      t.column :cook_time_hours,    :integer, :default => 0
      t.column :cook_time_minutes,  :integer
      t.column :preparation,        :text
      t.column :yield,              :string
      t.column :source,             :string
      t.column :image_url,          :string
    end
  end

  def self.down
    drop_table :recipes
  end
end
