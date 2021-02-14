require 'rails_helper'

describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    # it {should validate_presence_of :name}
    # it {should validate_presence_of :description}
    # it {should validate_presence_of :sex}
    # it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}
  end

  describe 'class methods' do

  end

  describe 'instance methods' do

  end
end
