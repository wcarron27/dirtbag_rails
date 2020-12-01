# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
user = User.create({ email: 'ab@example.com', password: 'Abcdefgh1' })
user = User.create({ email: 'mh@example.com', password: 'Abcdefgh1' })
user = User.create({ email: 'lg@example.com', password: 'Abcdefgh1' })

