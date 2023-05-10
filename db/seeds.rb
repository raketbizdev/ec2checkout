# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# 10.times do |i|
#   customer = User.create!(
#     email: "user_#{i + 1}@example.com",
#     password: 'password',
#     password_confirmation: 'password',
#   )
#   # customer.confirm
# end

storefronts = Storefront.all

storefronts.each do |storefront|
  100.times do
    product = storefront.products.build(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(sentence_count: 2),
      sale_price: Faker::Commerce.price(range: 20..100.0, as_string: false),
      price: Faker::Commerce.price(range: 50..200.0, as_string: false),
      link_url: Faker::Internet.url,
      user_id: storefront.user_id
    )
    product.save!
  end
end