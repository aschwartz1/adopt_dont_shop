class ApplicationsController < ApplicationController
  def show
    @application = Application.find(id_param)
  end

  def new
  end

  def create
    new_app = Application.create!(application_params)

    redirect_to "/applications/#{new_app.id}"
  end

  private

  def application_params
    params.permit(:name, :street, :city, :zip_code)
  end

  def id_param
    params[:id]
  end
end
