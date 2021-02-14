require 'rails_helper'

RSpec.describe 'Applications show page' do
  before :each do
    @application = Application.create!(application_params)
  end

  describe 'as a visitor' do
    it 'shows all applications' do
      visit "applications/#{@application.id}"

      expect(page).to have_content('Benedict Cumberbatch')
      expect(page).to have_content('123 My Lane')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('12345')
      expect(page).to have_content('In Progress')
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
    description: 'Because I\'m me.'
  }
end
