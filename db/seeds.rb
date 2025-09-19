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
  email: "Shundi@gmail.com",
  relationship: "You",
  latitude: 35.6764,
  longitude: 139.6500,
  avatar: "default.png",
  family: family
)


contact = Contact.create!(
  name: "Junji Nakada",
  telephone: "+81 000-0000-0000",
  email: "junji@gmail.com",
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
  contact: usrContact
)

home = TypePlace.create!(
  description: "Home",
  avatar: "home.png"
)

office = TypePlace.create!(
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
  type_place: home,
  latitude: 35.52560544574428,
  longitude: 139.711660032446,
  avatar: "home.png"
)

fatherAddr = Address.create!(
  postal_code: "210-4561",
  prefecture: "Kanagawa",
  city: "Kawsaki",
  district: "Ooshima",
  block: "10-1",
  building_name: "LO HERMANO",
  number: "24",
  description: "Office",
  type_place: office,
  latitude: 35.52887148390769,
  longitude: 139.70571658854823,
  avatar: "office.png"
)

puts "list adress"

ListAddress.create!(
  address: address,
  contact: usrContact
)

ListAddress.create!(
  address: address,
  contact: contact
)

ListAddress.create!(
  address: fatherAddr,
  contact: contact
)
puts "Contact created!"
