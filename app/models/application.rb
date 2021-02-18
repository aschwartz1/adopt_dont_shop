class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street, :city, :state, :zip_code, presence: true

  enum status: { in_progress: 0, pending: 1, accepted: 2, rejected: 3 }

  def add_pet(pet)
    pets.push(pet) unless pets.exists?(id: pet.id)
  end

  def submittable?
    in_progress? && number_of_pets > 0
  end

  def number_of_pets
    pets.count
  end

  def pretty_status
    status.titleize
  end
end
