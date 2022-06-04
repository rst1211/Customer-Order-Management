require 'rails_helper'

RSpec.describe Customer, type: :model do
 
  describe 'validations' do 

    it 'validates name' do
      cust = Customer.new
      cust.name = 'ab' 
      cust.validate 
      #byebug
      expect(cust.errors[:name]).to eq(["is too short (minimum is 6 characters)"]) 
    end

    it 'validates presence of email' do
      cust = Customer.new
      cust.email = '' 
      cust.validate 
      byebug
      expect(cust.errors[:email]).to include("Enter the valid email address.","can't be blank.") 
    end
  

    it 'validates presence of phone' do
      cust = Customer.new
      cust.phone = '' 
      cust.validate 
      #byebug
      expect(cust.errors[:phone]).to include("can't be blank", "Enter the valid phone number.") 
    end

    it 'validates address' do
      cust = Customer.new
      cust.address = '' 
      cust.validate 
      #byebug
      expect(cust.errors[:address]).to include("is too short (minimum is 4 characters)") 
    end


  end

end