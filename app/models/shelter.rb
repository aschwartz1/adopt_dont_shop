class Shelter < ApplicationRecord
  has_many :pets

  def self.all_reverse_name_sort
    find_by_sql('SELECT * FROM shelters ORDER BY name DESC')
  end

  def self.with_pending_applications
    Shelter.joins(pets: [:applications]).where('applications.status = ?', Application.statuses[:pending])
  end
end
