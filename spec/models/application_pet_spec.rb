require 'rails_helper'

describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with(pending: 1, accepted: 2, rejected: 3) }
  end

  # describe 'instance methods' do
  #   describe '#pretty_status' do
  #     it 'prettify :in_progress' do
  #       application = Application.create!(application_params(:in_progress))
  #       expect(application.pretty_status).to eq('In Progress')
  #     end

  #     it 'prettify :pending' do
  #       application = Application.create!(application_params(:pending))
  #       expect(application.pretty_status).to eq('Pending')
  #     end

  #     it 'prettify :accepted' do
  #       application = Application.create!(application_params(:accepted))
  #       expect(application.pretty_status).to eq('Accepted')
  #     end

  #     it 'prettify :rejected' do
  #       application = Application.create!(application_params(:rejected))
  #       expect(application.pretty_status).to eq('Rejected')
  #     end
  #   end
  # end
end
