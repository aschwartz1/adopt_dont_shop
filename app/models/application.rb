class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: { in_progress: 0, pending: 1, accepted: 2, rejected: 3 }

  def pretty_status
    status.titleize
  end
end
