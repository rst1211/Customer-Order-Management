require 'rails_helper'


RSpec.describe 'Customers', type: :request do
  let(:user) { create(:user) }
  let(:customer) {create(:customer)}
 
  describe 'customers#index' do
    

    context 'when user is not logged in' do
      it 'redirects to login page with appropriate flash message' do
        get '/' 
        expect(response.code).to eq('302')
      end
    end

    context 'when user is logged in' do
      #sign_in_resource(user)
      it "should return 200:ok" do
        
        execute_with_resource_sign_in(user) do
          #byebug
          get '/'
          expect(response).to have_http_status(:success)
        end
      end

      it 'is expected to assign customer instance variable' do
        #byebug
        expect(assigns[customers]).to eq(Customer.all)
      end
    end
  end

  describe 'customers#new' do
    before do
      get '/add-customer'
    end

    it 'is expected to assign customer as new instance variable' do
      expect(assigns[:customer]).to be_instance_of(Customer)
    end
  end
end