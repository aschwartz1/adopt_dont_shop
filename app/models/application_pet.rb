class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum status: { pending: 1, accepted: 2, rejected: 3 }

  def self.applications_with_pets(application_id)
    where(application_id: application_id).joins(:pet)
  end

  def pretty_status
    status.titleize
  end
end
