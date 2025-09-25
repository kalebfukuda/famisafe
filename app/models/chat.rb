class Chat < ApplicationRecord
  has_many :messages, dependet: :destroy
end
