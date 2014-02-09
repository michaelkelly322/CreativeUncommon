
FactoryGirl.define do
  factory :user do
    first_name    "Michael"
    last_name     "Kelly"
    email         "michaelkelly322@gmail.com"
    password      "password"
    password_confirmation "password"
  end
end
