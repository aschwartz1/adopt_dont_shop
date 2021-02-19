class Shelter < ApplicationRecord
  has_many :pets

  def self.all_reverse_name_sort
    find_by_sql('SELECT * FROM shelters ORDER BY name DESC')
  end
end
