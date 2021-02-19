class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all_reverse_name_sort
    @shelters_with_pending_apps = Shelter.with_pending_applications
  end
end

