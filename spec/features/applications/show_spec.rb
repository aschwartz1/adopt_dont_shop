require 'rails_helper'

RSpec.describe 'Applications show page' do
  before :each do
    shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @sparky = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
    @barky = shelter.pets.create!(image:"", name: "Barky", description: "dog", approximate_age: 4, sex: "female")
    @beckett = shelter.pets.create!(image:"", name: "Beckett", description: "cat", approximate_age: 2, sex: "male")
    @application = Application.create!(application_params)
  end

  describe 'as a visitor' do
    describe 'when I search for pets' do
      it 'only in progress applications can search for pets' do
        @application.pending!
        visit "/applications/#{@application.id}"

        expect(page).to_not have_selector('#app-pets-search')
      end

      it 'allows searching for pets' do
        visit "/applications/#{@application.id}"

        within('#app-pets-search') do
          fill_in :pet_search, with: 'Beckett'
          click_button 'Search'
        end

        expect(current_path).to eq("/applications/#{@application.id}")
        within('#app-pets-search') do
          expect(page).to have_content('Beckett')
        end
      end

      it 'I can add pets from search results to the application' do
        visit "/applications/#{@application.id}"

        within('#app-pets-search') do
          fill_in :pet_search, with: 'Beckett'
          click_button 'Search'
        end

        expect(current_path).to eq("/applications/#{@application.id}")

        within('#app-pets-search') do
          page.find("#add-pet-#{@beckett.id}").click
        end

        expect(current_path).to eq("/applications/#{@application.id}")

        within('#app-pets-all') do
          expect(page).to have_content(@beckett.name)
        end
      end
    end

    describe 'the page' do
      it 'shows application info' do
        visit "/applications/#{@application.id}"

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
        ApplicationPet.create!(application_id: @application.id, pet_id: @sparky.id)
        ApplicationPet.create!(application_id: @application.id, pet_id: @barky.id)

        visit "/applications/#{@application.id}"

        within('#app-pets-all') do
          expect(page).to have_link(@sparky.name)
          expect(page).to have_link(@barky.name)

          # Only testing one of the links
          click_link(@sparky.name)
          expect(current_path).to eq("/pets/#{@sparky.id}")
        end
      end

      it 'can submit when there are pets' do
        ApplicationPet.create!(application_id: @application.id, pet_id: @sparky.id)
        ApplicationPet.create!(application_id: @application.id, pet_id: @barky.id)

        visit "/applications/#{@application.id}"

        within('#submit-app') do
          expect(page).to have_button('Submit Application')
          fill_in('description', with: 'I have love to give')
          click_button('Submit Application')
        end

        expect(current_path).to eq("/applications/#{@application.id}")

        within('#app-info') do
          expect(page).to have_content('Pending')
        end

        expect(page).to_not have_selector('#app-pets-search')
      end

      it 'has no submit button when no pets are added' do
        ApplicationPet.create!(application_id: @application.id, pet_id: @sparky.id)
        ApplicationPet.create!(application_id: @application.id, pet_id: @barky.id)
        @application.pending!

        visit "/applications/#{@application.id}"

        expect(page).to_not have_selector('#submit-app')
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
end

