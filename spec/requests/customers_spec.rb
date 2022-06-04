require 'rails_helper'


RSpec.describe 'Customers', type: :request do
  let(:user) { create(:user) }
  let(:customer) {create(:customer,user: user)}
#===================================================================== 
  describe 'customers#index' do
    

    context 'when user is not logged in' do
      it 'redirects to login page with appropriate error message' do
        get '/' 
        #byebug
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
        customer
        execute_with_resource_sign_in(user) do
          get '/'
          #byebug
          expect(assigns[:customer]).to eq(Customer.all)
        end
      end
    end
  end

#====================================================================
  describe 'customers#new' do

    it 'is expected to assign customer as new instance variable' do
      execute_with_resource_sign_in(user) do
        get '/add-customer'
        #byebug
        expect(assigns[:customer]).to be_instance_of(Customer)
      end
    end
  end


#====================================================================

  describe 'customers#create' do
    context 'when params are correct' do
      it 'should create a new customer' do
        execute_with_resource_sign_in(user) do 
          post "/add-customer", { :customer => {
              name:'riddhi',
              email:'riddhitakwale@gmail.com',
              phone:'9810273441',
              address:'Pune',
              user_id: user.id
        }
        }          
          #byebug
          expect(assigns[:customer]).to be_instance_of(Customer)
        end
      end

      it 'is expected to redirect to root path' do
        execute_with_resource_sign_in(user) do 
          post "/add-customer", { :customer => {
            name:'riddhi',
            email:'riddhitakwale@gmail.com',
            phone:'9810273441',
            address:'Pune',
            user_id: user.id
          }
          } 
          is_expected.to redirect_to root_path
        end
      end

      it 'is expected to display flash message' do
        execute_with_resource_sign_in(user) do 
          post "/add-customer", { :customer => {
            name:'riddhi',
            email:'riddhitakwale@gmail.com',
            phone:'9810273441',
            address:'Pune',
            user_id: user.id
          }
          } 
          expect(flash[:notice]).to eq("Successfully created account !")
        end
      end

    end
    context 'when params are incorrect' do
      it 'should render a template' do
        execute_with_resource_sign_in(user) do 
          post "/add-customer", { :customer => {
            name: '',
            email: '',
            phone: '',
            address: '',
            user_id:  0
          }
        }
          is_expected.to render_template(:new)
        end
      end

      it 'is expected to add some error messages' do
        execute_with_resource_sign_in(user) do 
          post "/add-customer", { :customer => {
            name: '',
            email: '',
            phone: '',
            address: '',
            user_id:  0
          }
        }
          expect(assigns[:customer].errors[:name]).to eq(["is too short (minimum is 6 characters)"])
          expect(assigns[:customer].errors[:email]).to eq(["Enter the valid email address.", "can't be blank."])
          expect(assigns[:customer].errors[:phone]).to eq(["can't be blank", "Enter the valid phone number."])
          expect(assigns[:customer].errors[:address]).to eq(["is too short (minimum is 4 characters)"])
        end
      end

    end
  end
#===============================================================================

  describe 'customers#edit' do
    context 'when customer id is valid' do
      it 'is expected to set customer instance variable' do
        execute_with_resource_sign_in(user) do 
          #byebug
          #get '/update-customer/:id',{:id => customer.id}
          #byebug
          get edit_customer_path(id: customer.id)
          expect(assigns[:customer]).to eq(Customer.find_by(id: customer.id))
        end
      end


      it 'is expected to render edit template' do
        execute_with_resource_sign_in(user) do 
          get edit_customer_path(id: customer.id)
          is_expected.to render_template(:edit)
        end
      end

    end
  end 
#================================================================

  describe 'customers#update' do
    context 'when updates are valid' do
      it 'should update the customer' do
        execute_with_resource_sign_in(user) do
          post update_customer_path(id: customer.id, customer: { name: 'test name' })
          expect(customer.reload.name).to eq('test name')
          is_expected.to redirect_to(root_path)
          expect(flash[:notice]).to eq('Customer details updated!')
        end
      end
    end
  end


end