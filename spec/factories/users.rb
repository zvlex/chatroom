FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@gmail.com" }

  factory :user do
    email { generate(:email) }
    password 'secret'
    password_confirmation 'secret'
    is_admin false
  end
end
