class Contact < ApplicationRecord
  belongs_to :family
  has_many :users
  has_many :addresses, through: :list_adresses
end
