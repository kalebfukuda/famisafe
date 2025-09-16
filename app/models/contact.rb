class Contact < ApplicationRecord
  belongs_to :family
  has_many :users, through: :family
end
