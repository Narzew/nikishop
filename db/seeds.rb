# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create categories
burgers = Category.find_or_create_by(name: 'Burgery', seq: 1)
dishes = Category.find_or_create_by(name: 'Dania barowe', seq: 2)
addons = Category.find_or_create_by(name: 'Dodatki', seq: 3)

# Create products

# Burgery
Product.find_or_create_by(name: 'Burger z wołowiną', category_id: burgers.id,
                          description: 'Przepyszny burger z wołowiną', price: 10.00)
Product.find_or_create_by(name: 'Hamburger', category_id: burgers.id, description: 'Zwykły hamburger.', price: 5.00)
Product.find_or_create_by(name: 'Cheeseburger', category_id: burgers.id, description: 'Zwykły cheeseburger',
                          price: 8.00)
Product.find_or_create_by(name: 'Big Burger', category_id: burgers.id,
                          description: 'Mega burger. Specjalność naszego szefa', price: 15.00)

# Dania barowe
Product.find_or_create_by(name: 'Pierogi ruskie', category_id: dishes.id, description: 'Pierogi ruskie z cebulką',
                          price: 10.00)
Product.find_or_create_by(name: 'Bigos', category_id: dishes.id, description: 'Bigos. Narodowe danie polskie',
                          price: 8.50)
Product.find_or_create_by(name: 'Łazanki', category_id: dishes.id, description: 'Zwykły cheeseburger', price: 9.00)
Product.find_or_create_by(name: 'Fasolka po bretońsku', category_id: dishes.id,
                          description: 'Kto nie zna pysznej fasolki?', price: 7.00)
Product.find_or_create_by(name: 'Frytki', category_id: dishes.id, description: 'Pyszne frytki', price: 5.00)
Product.find_or_create_by(name: 'Hot-dog', category_id: dishes.id, description: 'Hot-dog z parówką', price: 5.00)

# Dodatki
Product.find_or_create_by(name: 'Ketchup', category_id: addons.id,
                          description: 'Dodaj ketchup do frytek lub innego dania', price: 1.00)
Product.find_or_create_by(name: 'Musztarda', category_id: addons.id, description: 'Dodaj musztardę', price: 1.00)
Product.find_or_create_by(name: 'Sos czosnkowy', category_id: addons.id, description: 'Dodaj sos czosnkowy',
                          price: 1.50)
Product.find_or_create_by(name: 'Cebulka', category_id: addons.id, description: 'Dodatkowa porcja cebulki', price: 1.00)
