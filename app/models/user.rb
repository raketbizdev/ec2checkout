class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_storefront_with_random_name

  has_one :storefront

  private

  def create_storefront_with_random_name
    random_numbers = rand(10**8).to_s.rjust(8, '0')
    domain_word = Faker::Internet.domain_word.gsub(/[-_]/, '')
    subdomain = domain_word + random_numbers
    storefront = Storefront.new(store_name: domain_word, subdomain: subdomain, user_id: id)
  
    if storefront.save
      update(storefront: storefront)
    else
      puts "Failed to save the new associated storefront: #{storefront.errors.full_messages}"
    end
  end
end
