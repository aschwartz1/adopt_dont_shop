require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end

  describe 'class methods' do
    it '::all_reverse_name_sort' do
      shelter1 = Shelter.create!(name: "A Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      shelter2 = Shelter.create!(name: "B Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
      shelter3 = Shelter.create!(name: "C Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)

      expect(Shelter.all_reverse_name_sort).to eq([shelter3, shelter2, shelter1])
    end
  end
end
