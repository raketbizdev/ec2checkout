class Storefront < ApplicationRecord
  belongs_to :user
  validates :subdomain, uniqueness: { case_sensitive: false, message: "must be unique" }
  validates :subdomain, presence: true, length: { minimum: 3 }, format: { with: /\A[a-z0-9]+(-[a-z0-9]+)?\z/i, message: "should be in format of 'randomname' or 'randomname-12345678'" }
  has_many :products
  validates :name, presence: true
  # Method to search products by keyword and category
  # def self.search(keyword, category)
  #   if category.present?
  #     where('name ILIKE ? AND category ILIKE ?', "%#{keyword}%", "%#{category}%")
  #   else
  #     where('name ILIKE ?', "%#{keyword}%")
  #   end
  # end
end
