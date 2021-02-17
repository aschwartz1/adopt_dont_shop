class ApplicationPetsController < ApplicationController
  def create
    app = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    app_pet = ApplicationPet.new(application: app, pet: pet)
    app_pet.save

    redirect_to "/applications/#{params[:application_id]}"
  end

  private

  def shelter_pets_params
    params.permit(:image, :name, :description, :approximate_age, :sex, :adoptable)
  end
end
