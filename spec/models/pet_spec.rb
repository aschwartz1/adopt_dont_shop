require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets) }
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end

  describe 'class methods' do
    describe '::fill_by_name' do
      it 'can return based on exact match' do
        shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
        fluffy = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
        smoothy = shelter.pets.create!(sex: :female, name: "Smoothy", approximate_age: 4, description: 'a little strange')
        sharpy = shelter.pets.create!(sex: :female, name: "Sharpy", approximate_age: 4, description: "Please don't touch")

        expect(Pet.fill_by_name('Fluffy')).to eq([fluffy])
      end

      it 'is case insensitive' do
        shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
        fluffy = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
        smoothy = shelter.pets.create!(sex: :female, name: "Smoothy", approximate_age: 4, description: 'a little strange')
        sharpy = shelter.pets.create!(sex: :female, name: "Sharpy", approximate_age: 4, description: "Please don't touch")

        expect(Pet.fill_by_name('fluffy')).to eq([fluffy])
      end

      it 'returns partial matches' do
        shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
        fluffy = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
        smoothy = shelter.pets.create!(sex: :female, name: "Smooth No-fluff", approximate_age: 4, description: 'a little strange')
        sharpy = shelter.pets.create!(sex: :female, name: "Sharpy", approximate_age: 4, description: "Please don't touch")

        expect(Pet.fill_by_name('Fluff')).to eq([fluffy, smoothy])
      end
    end
  end
end
