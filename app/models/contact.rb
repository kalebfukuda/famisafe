class Contact < ApplicationRecord
  has_many :contacts_lists
  has_many :users, through: :contacts_lists
end
