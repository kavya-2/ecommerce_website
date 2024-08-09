class Category < ApplicationRecord
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
	has_many :subcategories, class_name: 'Category', foreign_key: 'parent_category_id'
  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many :products

  # Define the search index mapping
  def as_indexed_json(options = {})
    as_json(only: [:name])
  end

  # Define search scope
  def self.search(query)
    __elasticsearch__.search(
      query: {
        match: {
          name: query
        }
      }
    ).records
  end
end
