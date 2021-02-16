class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street, :city, :state, :zip_code, presence: true

  enum status: { in_progress: 0, pending: 1, accepted: 2, rejected: 3 }

  def pretty_status
    status.titleize
  end
end
