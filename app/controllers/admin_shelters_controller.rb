class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all_reverse_name_sort
  end
end

