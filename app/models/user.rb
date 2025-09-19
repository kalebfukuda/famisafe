class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :contact, optional: true

  # Todos os contatos da família do usuário
  has_many :contacts, through: :contact, source: :family_contacts

  # Todos os endereços dos contatos da família
  has_many :addresses, through: :contacts
end
