class ApplicationsController < ApplicationController
  def show
    @application = Application.find(id_param)
    @pet_search = params[:pet_search]

    if @pet_search
      @search_results = Pet.fill_by_name(@pet_search)
    end
  end

  def new
  end

  def create
    new_app = Application.create!(application_params)

    redirect_to "/applications/#{new_app.id}"
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zip_code, :description)
  end

  def id_param
    params[:id]
  end
end
