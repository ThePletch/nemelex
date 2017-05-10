FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "some_user#{n}@zombo.com"}
    password 'butts1'
    password_confirmation 'butts1'
  end
end
