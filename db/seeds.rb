puts "Cleaning the DB...."
Address.delete_all
Contact.destroy_all
User.destroy_all

puts "Creating Contact.... \n"
user = User.create!(
  email: "admin@admin.com",
  password: "123456",
  password_confirmation: "123456"
)
contact = Contact.create!(
  name: "Father Father",
  telephone: "+81 000-0000-0000",
  email: "Father@Father.com",
  relationship: "Father"
)

ContactsList.create!(
  user: user,
  contact: contact
)

puts "Contact created!"
