class Contact < ApplicationRecord
  belongs_to :family

  has_many :users
  has_many :list_addresses, dependent: :destroy
  has_many :addresses, through: :list_addresses

  # Todos os contatos da mesma família
  has_many :family_contacts, through: :family, source: :contacts

  validates :name, presence: true

  def self.avatars
    Dir.glob(Rails.root.join("app/assets/images/icons/avatars/*.png"))
       .map { |path| File.basename(path) }
  end
end
