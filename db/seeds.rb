# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end if Rails.env.development?



category_names = ["Books", "Electronics", "Home Decor", "Fashion", "Toys", "Furniture"]
categories = category_names.map { |name| Category.find_or_create_by!(name: name) }


product_details = [
  { name: "Vintage Clock", description: "A beautiful vintage clock.", price: 25.50, quantity_available: 10, category: "Home Decor" },
  { name: "Ruby Programming Book", description: "Learn programming in Ruby.", price: 12.99, quantity_available: 5, category: "Books" },
  { name: "Retro Gaming Console", description: "Experience nostalgia with this retro gaming console.", price: 80.00, quantity_available: 3, category: "Electronics" },
  { name: "Leather Wallet", description: "A premium leather wallet for everyday use.", price: 45.00, quantity_available: 15, category: "Fashion" },
  { name: "Action Figure", description: "Collectible action figure from popular movies.", price: 29.99, quantity_available: 20, category: "Toys" },
  { name: "Bluetooth Headphones", description: "Wireless headphones with excellent sound quality.", price: 59.99, quantity_available: 10, category: "Electronics" },
  { name: "Vintage Floral Dress", description: "A beautiful vintage floral dress for any occasion.", price: 75.00, quantity_available: 4, category: "Fashion" },
  { name: "Science Experiment Kit", description: "Fun and educational science kit for kids.", price: 49.95, quantity_available: 8, category: "Toys" },
  { name: "Coffee Table Book", description: "A large coffee table book filled with stunning photographs.", price: 30.00, quantity_available: 12, category: "Books" },
  { name: "Decorative Throw Pillow", description: "Add comfort and style to your home decor.", price: 19.99, quantity_available: 25, category: "Home Decor" },
  { name: "Ergonomic Office Chair", description: "Comfortable and stylish office chair.", price: 150.00, quantity_available: 5, category: "Furniture" }
]

product_details.each do |detail|
  category = categories.find { |c| c.name == detail[:category] }
  Product.find_or_create_by!(name: detail[:name]) do |product|
    product.description = detail[:description]
    product.price = detail[:price]
    product.quantity_available = detail[:quantity_available]
    product.category = category
  end
end

puts "Created #{Category.count} categories and #{Product.count} products."

# Seed initial content for About page
PageContent.create_with(title: 'About Us', content: 'This is some about us text.').find_or_create_by!(slug: 'about')

# Seed initial content for Contact page
PageContent.create_with(title: 'Contact Us', content: 'This is how you can contact us.').find_or_create_by!(slug: 'contact')

