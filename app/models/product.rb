class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  before_validation :initialize_arrays

  belongs_to :category
  has_many_attached :images
  serialize :images, Array
  serialize :variants, Array
  serialize :colors, Array
  serialize :sizes, Array

  def as_indexed_json(options = {})
    as_json(only: [:title, :description, :price, :colors, :sizes, :category_id])
  end

  private

  def initialize_arrays
    self.colors ||= []
    self.sizes ||= []
  end
end
