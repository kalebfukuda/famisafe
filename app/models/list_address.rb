class ListAddress < ApplicationRecord
  belongs_to :address
  belongs_to :contact

  validates :address_id, :contact_id, presence: true
end
