class Address < ApplicationRecord
  belongs_to :type_place
  has_many :contacts, through: :list_adresses
end
