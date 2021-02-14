class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: { 'In Progress' => 0, 'Pending' => 1, 'Accepted' => 2, 'Rejected' => 3 }

  # validates_presence_of :name, :description, :approximate_age, :sex

  # validates :approximate_age, numericality: {
  #             greater_than_or_equal_to: 0
  #           }

  # enum sex: [:female, :male]
end
