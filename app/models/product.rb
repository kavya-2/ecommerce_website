class Product < ApplicationRecord
  belongs_to :category
  serialize :images, Array
  serialize :variants, Array
end
