class Product < ApplicationRecord
  belongs_to :storefront
  belongs_to :user
end
