# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ApplicationRecord.transaction do
    cat1 = Cat.new(sex: 'M', birth_date: '2006/02/05', name: 'Theo', color: 'red', description: "I'm trash.")
    cat2 = Cat.new(sex: 'M', birth_date: '1999/02/01', name: 'Bryan', color: 'blue', description: "I'm a beast.")
    cat3 = Cat.new(sex: 'F', birth_date: '2000/03/17', name: 'Kitty', color: 'pink', description: "I'm cute.")
    
    cat1.save
    cat2.save
    cat3.save
    
end