class Contact < ApplicationRecord
  belongs_to :family

  has_many :users
  has_many :list_addresses, dependent: :destroy
  has_many :addresses, through: :list_addresses

  # Todos os contatos da mesma família
  has_many :family_contacts, through: :family, source: :contacts

  validates :name, presence: true
end
