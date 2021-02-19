require 'rails_helper'

RSpec.describe 'Admin shelters index page' do
  before :each do
  end

  describe 'all shelters section' do
    it 'shows shelters in reverse alphabetical order' do
      shelter1 = Shelter.create!(name: "A Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      shelter2 = Shelter.create!(name: "B Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
      shelter3 = Shelter.create!(name: "C Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)

      visit '/admin/shelters'

      within('#all-shelters') do
        actual_order = page.all('.shelter-name').map(&:text)
        expect(actual_order).to eq(['C Shelter', 'B Shelter', 'A Shelter'])
      end
    end
  end

  describe 'pending applications section' do
    it 'shows shelters with pending applications' do
      shelter1 = Shelter.create!(name: "A Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      shelter2 = Shelter.create!(name: "B Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
      shelter3 = Shelter.create!(name: "C Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
      sparky = shelter1.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
      barky = shelter2.pets.create!(image:"", name: "Barky", description: "dog", approximate_age: 4, sex: "female")
      beckett = shelter3.pets.create!(image:"", name: "Beckett", description: "cat", approximate_age: 2, sex: "male")
      pending_app1 = Application.create!(application_params(:pending))
      pending_app1.pets.push(sparky)
      pending_app2 = Application.create!(application_params(:pending))
      pending_app2.pets.push(barky)
      in_progress_app = Application.create!(application_params(:in_progress))
      in_progress_app.pets.push(beckett)

      visit '/admin/shelters'

      within('#pending-shelters') do
        actual_pending_shelters = page.all('.shelter-name').map(&:text)
        expect(actual_pending_shelters).to eq(['A Shelter', 'B Shelter'])
      end
    end
  end

  def application_params(status_symbol)
    {
      name: 'Benedict Cumberbatch',
      street: '123 My Lane',
      city: 'Denver',
      state: 'CO',
      zip_code: '12345',
      description: "Because I'm me.",
      status: status_symbol
    }
  end
end
