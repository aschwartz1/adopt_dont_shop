class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # TODO if this works, move it to the model
    @application_pets = ApplicationPet.where(application_id: params[:id]).joins(:pet)
  end

  def update
    app_id = params[:application_id]
    pet_id = params[:pet_id]

    begin
      app_pet = ApplicationPet.find_by!(application_id: app_id, pet_id: pet_id)
      if params[:admin_action] == 'approve'
        app_pet.accepted!
      elsif params[:admin_action] == 'reject'
        app_pet.rejected!
      else
        # How did we get here
      end
    rescue => error
      flash[:error] = error.message
    end

    redirect_to "/admin/applications/#{app_id}"
  end
end
