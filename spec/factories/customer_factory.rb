FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { '9876543210'  }
    address { Faker::Address.city}
  end

  factory :user do
    email { Faker::Internet.email }
    password { 'password'  }
  end
end