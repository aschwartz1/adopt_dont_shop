require 'rails_helper'

RSpec.describe 'Applications show page' do
  before :each do
    shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @sparky = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
    @barky = shelter.pets.create!(image:"", name: "Barky", description: "dog", approximate_age: 4, sex: "female")
    @application = Application.create!(application_params)

    ApplicationPet.create!(application_id: @application.id, pet_id: @sparky.id)
    ApplicationPet.create!(application_id: @application.id, pet_id: @barky.id)
  end

  describe 'as a visitor' do
    it 'shows application info' do
      visit "applications/#{@application.id}"

      within('#app-info') do
        expect(page).to have_content('Benedict Cumberbatch')
        expect(page).to have_content('123 My Lane')
        expect(page).to have_content('Denver')
        expect(page).to have_content('CO')
        expect(page).to have_content('12345')
        expect(page).to have_content("Because I'm me.")
        expect(page).to have_content('In Progress')
      end
    end

    it 'shows all pets on the application' do
      visit "applications/#{@application.id}"

      within('#app-pets') do
        expect(page).to have_link(@sparky.name)
        expect(page).to have_link(@barky.name)

        # Only testing one of the links
        click_link(@sparky.name)
        expect(current_path).to eq("/pets/#{@sparky.id}")
      end
    end
  end
end

def application_params
  {
    name: 'Benedict Cumberbatch',
    street: '123 My Lane',
    city: 'Denver',
    state: 'CO',
    zip_code: '12345',
    description: "Because I'm me."
  }
end