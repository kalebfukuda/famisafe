class Address < ApplicationRecord
  belongs_to :type_place

  has_many :list_addresses, dependent: :destroy
  has_many :contacts, through: :list_addresses

  validates :city, :prefecture, presence: true
end
