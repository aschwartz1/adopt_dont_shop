require 'rails_helper'

RSpec.describe 'Applications new page' do
  describe 'as a visitor' do
    it 'can submit a new application' do
      visit '/applications/new'

      within('#new-form') do
        fill_in(:name, with: 'Benedict Cumberbatch')
        fill_in(:street, with: '123 My Lane')
        fill_in(:city, with: 'Denver')
        fill_in(:state, with: 'CO')
        fill_in(:zip_code, with: '12345')
        fill_in(:description, with: "Because I'm me.")

        click_on(:submit)
      end

      expect(current_path).to match(%r{applications/\d+})
      expect(page).to have_content('Benedict Cumberbatch')
      expect(page).to have_content('123 My Lane')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('12345')
      expect(page).to have_content("Because I'm me.")
      expect(page).to have_content('In Progress')
    end
  end
end
