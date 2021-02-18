class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    app_id = params[:application_id]
    pet_id = params[:pet_id]

    begin
      app_pet = ApplicationPet.find_by!(application_id: app_id, pet_id: pet_id)

      if params[:to_status] == 'approve'
        app_pet.approved!
      else
        app_pet.rejected!
      end
    rescue => error
      flash[:error] = error.message
    end

    redirect_to "/admin/applications/#{app_id}"
  end
end
