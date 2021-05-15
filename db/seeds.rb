# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def load_seed_file(seed)
  puts seed
  load seed
end

Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each { |full_path| load_seed_file(full_path) }

Dir['engines/*/db/seeds/*.rb'].sort.each do |path|
  full_path = Rails.root.join(path)
  load_seed_file(full_path)
end