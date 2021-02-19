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

    it '::with_pending_applications' do
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

      expect(Shelter.with_pending_applications).to eq([shelter1, shelter2])
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
