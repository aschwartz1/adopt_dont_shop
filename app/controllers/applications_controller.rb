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
    new_app = Application.new(application_params)

    if new_app.save
      redirect_to "/applications/#{new_app.id}"
    else
      flash.now[:error] = new_app.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zip_code)
  end

  def id_param
    params[:id]
  end
end
