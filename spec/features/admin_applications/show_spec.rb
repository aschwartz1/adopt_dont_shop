require 'rails_helper'

RSpec.describe 'Admin applications show page' do
  before :each do
    shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @sparky = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
    @barky = shelter.pets.create!(image:"", name: "Barky", description: "dog", approximate_age: 4, sex: "female")
    @beckett = shelter.pets.create!(image:"", name: "Beckett", description: "cat", approximate_age: 2, sex: "male")
    @application = Application.create!(application_params)
  end

  it 'shows application info' do
    visit "/admin/applications/#{@application.id}"

    within('#info') do
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

    visit "/admin/applications/#{@application.id}"

    within('#pets') do
      expect(page).to have_link(@sparky.name)
      expect(page).to have_link(@barky.name)

      # Only testing one of the links
      click_link(@sparky.name)
      expect(current_path).to eq("/pets/#{@sparky.id}")
    end
  end

  describe 'approve/reject pets' do
    it 'has a button to approve each listed pet' do
      ApplicationPet.create!(application_id: @application.id, pet_id: @sparky.id)
      ApplicationPet.create!(application_id: @application.id, pet_id: @barky.id)

      visit "/admin/applications/#{@application.id}"

      within("#pet-#{@sparky.id}") do
        click_button('Approve')
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")

      within("#pet-#{@sparky.id}") do
        expect(page).to_not have_button('Approve')
        expect(page).to have_content('Accepted')
      end
    end

    it 'has a button to reject each listed pet' do
      ApplicationPet.create!(application_id: @application.id, pet_id: @sparky.id)
      ApplicationPet.create!(application_id: @application.id, pet_id: @barky.id)

      visit "/admin/applications/#{@application.id}"

      within("#pet-#{@sparky.id}") do
        click_button('Reject')
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")

      within("#pet-#{@sparky.id}") do
        expect(page).to_not have_button('Reject')
        expect(page).to have_content('Rejected')
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
