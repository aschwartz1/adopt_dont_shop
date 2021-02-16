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

