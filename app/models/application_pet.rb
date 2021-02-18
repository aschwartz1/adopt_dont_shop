class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum status: { pending: 1, accepted: 2, rejected: 3 }

  def pretty_status
    status.titleize
  end
end
