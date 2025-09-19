class Family < ApplicationRecord
  has_many :contacts, dependent: :destroy
  has_many :users, through: :contacts

  validates :name, presence: true
end
