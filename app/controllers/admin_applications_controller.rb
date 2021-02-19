class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = ApplicationPet.applications_with_pets(params[:id])
  end

  def update
    app_pet = ApplicationPet.find_by(application_id: params[:application_id], pet_id: params[:pet_id])

    if app_pet
      if params[:admin_action] == 'approve'
        app_pet.accepted!
      elsif params[:admin_action] == 'reject'
        app_pet.rejected!
      else
        # How did we get here
      end
    else
      flash[:error] = error.message
    end

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end
