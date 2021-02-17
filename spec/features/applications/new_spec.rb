require 'rails_helper'

RSpec.describe 'Applications new page' do
  describe 'as a visitor' do
    describe 'and I submit without all form fields' do
      it 'shows flash message if no fields are filled out' do
        visit '/applications/new'

        within('#new-form') do
          click_on('Submit')
        end

        expect(page).to have_css('.flash-message')
      end

      xit 'I receive required form field notices' do
        visit '/applications/new'

        expect(page.find('#name[required=required]'))
        expect(page.find('#street[required=required]'))
        expect(page.find('#city[required=required]'))
        expect(page.find('#state[required=required]'))
        expect(page.find('#zip_code[required=required]'))
      end
    end

    describe 'and I fill out all form fields' do
      it 'can submit a new application' do
        visit '/applications/new'

        within('#new-form') do
          fill_in(:name, with: 'Benedict Cumberbatch')
          fill_in(:street, with: '123 My Lane')
          fill_in(:city, with: 'Denver')
          fill_in(:state, with: 'CO')
          fill_in(:zip_code, with: '12345')

          click_on('Submit')
        end

        expect(current_path).to match(%r{/applications/\d+})
        expect(page).to have_content('Benedict Cumberbatch')
        expect(page).to have_content('123 My Lane')
        expect(page).to have_content('Denver')
        expect(page).to have_content('CO')
        expect(page).to have_content('12345')
        expect(page).to have_content('In Progress')
      end
    end
  end
end
