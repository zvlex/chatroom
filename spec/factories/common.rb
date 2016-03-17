FactoryGirl.define do
  sequence(:username)  { |n| "test#{n}" }
  sequence(:email)     { |n| "test#{n}@gmail.com" }
  sequence(:room_name) { |n| "room#{n}" }

  factory :user do
    username { generate(:username) }
    email { generate(:email) }
    password 'secret'
    password_confirmation 'secret'
    is_admin false
  end

  factory :room do
    user
    name { generate(:room_name) }
    description 'Ruby group'
    is_visible true
  end

  factory :member do
    user
    room
    role 1
  end
end
