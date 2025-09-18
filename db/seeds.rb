puts "Cleaning the DB...."
Address.delete_all
Contact.destroy_all
User.destroy_all

puts "Creating Contact.... \n"
family = Family.create!(
  name: "Fukuda"
)

usrContact = Contact.create!(
  name: "Shundi Nakada",
  telephone: "+81 000-0000-0000",
  email: "Shundi@Father.com",
  relationship: "Father",
  latitude: 35.6764,
  longitude: 139.6500,
  avatar: "default.png",
  family: family
)


contact = Contact.create!(
  name: "Junji Nakada",
  telephone: "+81 000-0000-0000",
  email: "junji@Father.com",
  relationship: "Father",
  latitude: 35.6764,
  longitude: 139.6500,
  avatar: "father.png",
  family: family
)

user = User.create!(
  email: "kaleb@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  latitude: 35.6764,
  longitude: 139.6500,
  contact: usrContact
)

home = TypePlace.create!(
  description: "Home",
  avatar: "home.png"
)

TypePlace.create!(
  description: "Office",
  avatar: "office.png"
)

TypePlace.create!(
  description: "School",
  avatar: "school.png"
)

address = Address.create!(
  postal_code: "210-0410",
  prefecture: "Kanagawa",
  city: "Kawsaki",
  district: "Ooshima",
  block: "10-1",
  building_name: "La Shura",
  number: "10",
  description: "Home",
  type_place: home
)

puts "list adress"

ListAdress.create!(
  address: address,
  contact: usrContact
)

ListAdress.create!(
  address: address,
  contact: contact
)
puts "Contact created!"
