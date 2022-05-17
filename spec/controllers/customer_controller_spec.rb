require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  describe 'customers#index' do
    before do
      get :index
    end

    it 'is expected to assign customer instance variable' do
      expect(assigns[:customers])==(Customer.all)
    end
  end

  # describe 'customers#new' do
  #   before do
  #     get :new
  #   end

  #   it 'is expected to assign customer as new instance variable' do
  #     expect(assigns[:customer]).to be_instance_of(Customer)
  #   end
  # end
end