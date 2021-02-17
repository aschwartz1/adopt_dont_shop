require 'rails_helper'

describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should define_enum_for(:status).with(in_progress: 0, pending: 1, accepted: 2, rejected: 3) }
  end

  describe 'class methods' do

  end

  describe 'instance methods' do
    describe '#add_pet' do
      it 'can add pet to the application' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        sparky = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        barky = shelter.pets.create!(image:"", name: "Barky", description: "dog", approximate_age: 3, sex: "female")
        application = Application.create!(application_params(:in_progress))

        application.add_pet(sparky)
        application.add_pet(barky)
        expect(application.pets).to eq([sparky, barky])
      end

      it 'pets can only be added once' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        sparky = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        application = Application.create!(application_params(:in_progress))

        application.add_pet(sparky)
        application.add_pet(sparky)
        expect(application.pets).to eq([sparky])
      end
    end

    describe '#pretty_status' do
      it 'prettify :in_progress' do
        application = Application.create!(application_params(:in_progress))
        expect(application.pretty_status).to eq('In Progress')
      end

      it 'prettify :pending' do
        application = Application.create!(application_params(:pending))
        expect(application.pretty_status).to eq('Pending')
      end

      it 'prettify :accepted' do
        application = Application.create!(application_params(:accepted))
        expect(application.pretty_status).to eq('Accepted')
      end

      it 'prettify :rejected' do
        application = Application.create!(application_params(:rejected))
        expect(application.pretty_status).to eq('Rejected')
      end
    end

    describe '#submittable' do
      it 'can be submitted when in_progress and has pets' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        sparky = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        application = Application.create!(application_params(:in_progress))
        application.pets.push(sparky)

        expect(application.submittable?).to eq(true)
      end

      it 'must have pets to be submitted' do
        application = Application.create!(application_params(:in_progress))
        expect(application.submittable?).to eq(false)
      end

      it 'must be in_progress to be submitted' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        sparky = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        application = Application.create!(application_params(:pending))
        application.pets.push(sparky)

        expect(application.submittable?).to eq(false)
      end
    end

    describe '#number_of_pets' do
      it 'returns number of pets on the app' do
        shelter = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        sparky = shelter.pets.create!(image:"", name: "Sparky", description: "dog", approximate_age: 2, sex: "male")
        barky = shelter.pets.create!(image:"", name: "Barky", description: "dog", approximate_age: 4, sex: "female")
        application = Application.create!(application_params(:in_progress))
        application.pets.push(sparky)
        application.pets.push(barky)

        expect(application.number_of_pets).to eq(2)
      end

      it 'can be 0' do
        application = Application.create!(application_params(:in_progress))
        expect(application.number_of_pets).to eq(0)
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

