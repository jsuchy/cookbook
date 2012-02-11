class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients

  def self.search_clause
    return searchable_fields.map {|a| "#{a} LIKE ?"}.join(" OR ")
  end

  def self.searchable_fields
    return ["title", "preparation", "source"]
  end

  def belongs_to_user?(user_id)
    return self.user_id.to_s == user_id.to_s
  end
end
