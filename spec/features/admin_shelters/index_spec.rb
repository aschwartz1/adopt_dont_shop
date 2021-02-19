require 'rails_helper'

RSpec.describe 'Admin shelters index page' do
  before :each do
  end

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
