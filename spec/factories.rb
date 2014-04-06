
FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "First #{n}" }
    sequence(:last_name) { |n| "Last #{n}" }
    sequence(:email) { |n| "first_last_#{n}@example.com" }
    password      "password1"
    password_confirmation "password1"
  end
end
