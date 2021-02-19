require 'rails_helper'

describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with(pending: 1, accepted: 2, rejected: 3) }
  end

  describe 'class methods' do
    describe '::applications_with_pets' do
      it 'works' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        pet = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        app = Application.create!(application_params)
        ApplicationPet.create!(application_id: app.id, pet_id: pet.id, status: :pending)

        result = ApplicationPet.applications_with_pets(app.id)
        expect(result.count).to eq(1)
      end

      it 'has access to pet objects' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        pet = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        app = Application.create!(application_params)
        ApplicationPet.create!(application_id: app.id, pet_id: pet.id, status: :pending)

        result = ApplicationPet.applications_with_pets(app.id)
        expect(result.first.pet.name).to eq('Sparky')
      end
    end
  end

  describe 'instance methods' do
    describe '#pretty_status' do
      it 'prettify :pending' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        pet = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        app = Application.create!(application_params)
        app_pet = ApplicationPet.create!(application_id: app.id, pet_id: pet.id, status: :pending)
        expect(app_pet.pretty_status).to eq('Pending')
      end

      it 'prettify :accepted' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        pet = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        app = Application.create!(application_params)
        app_pet = ApplicationPet.create!(application_id: app.id, pet_id: pet.id, status: :accepted)
        expect(app_pet.pretty_status).to eq('Accepted')
      end

      it 'prettify :rejected' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        pet = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        app = Application.create!(application_params)
        app_pet = ApplicationPet.create!(application_id: app.id, pet_id: pet.id, status: :rejected)
        expect(app_pet.pretty_status).to eq('Rejected')
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
      description: "Because I'm me.",
    }
  end
end
