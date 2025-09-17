puts "Cleaning the DB...."
Address.delete_all
Contact.destroy_all
User.destroy_all

puts "Creating Contact.... \n"
family = Family.create!(
  name: "Fukuda"
)

user = User.create!(
  email: "kaleb@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  family: family
)
contact = Contact.create!(
  name: "Father Father",
  telephone: "+81 000-0000-0000",
  email: "Father@Father.com",
  relationship: "Father",
  family: family
)


puts "Contact created!"
