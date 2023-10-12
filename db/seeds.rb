# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

managers = Manager.create([
  {first_name: 'Emmerich', last_name: 'Pisani'},
  {first_name: 'Jakob', last_name: 'Krawiec'},
  {first_name: 'Kazimierz', last_name: 'Weimann'},
  {first_name: 'Czcibor', last_name: 'Roncalli'},
  {first_name: 'Iris', last_name: 'Grosse'},
  {first_name: 'Samuela', last_name: 'Falkenrath'},
  {first_name: 'Julian', last_name: 'Parma'},
  {first_name: 'Cipriano', last_name: 'Fonda'},
  {first_name: 'Marcela', last_name: 'Silvestri'},
  {first_name: 'Izolda', last_name: 'Abbandonato'},
])

Transaction.create!([
  {first_name: 'Steren', last_name: 'Nausikaa', from_currency: 'USD',
   to_currency: 'CAD', from_amount_cents: 200000, manager: managers[5]},
  {first_name: 'Muthoni', last_name: 'Iunia', from_currency: 'USD',
   to_currency: 'GBP', from_amount_cents: 300000, manager: managers[8]},
  {first_name: 'Anna', last_name: 'Bogali', from_currency: 'USD',
   to_currency: 'GBP', from_amount_cents: 11000, manager: managers[8]},
  {from_currency: 'USD', to_currency: 'AUD', from_amount_cents: 9000},
])
