require 'rails_helper'


RSpec.describe CustomersController, type: :controller do
  let(:customer) {create(:customer)}
  describe 'customers#index' do
    before do
      get :index
    end

    context 'when user is not logged in ' do
      it 'redirects to login page with appropriate flash message' do
        
      end
    end 

    it 'is expected to assign customer instance variable' do
     # byebug
      #customer
      expect(assigns[:customers])==(Customer.all)
    end
  end

  describe 'customers#new' do
    before do
      get :new
    end

    it 'is expected to assign customer as new instance variable' do
      expect(assigns[:customer]).to be_instance_of(Customer)
    end
  end
end