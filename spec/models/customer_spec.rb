require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'validations' do
    describe 'it validates email' do
      it { is_expected.to validate_presence_of(:email) }
    end
  end

end