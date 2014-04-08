FactoryGirl.define do
  factory :user do
    username     "uzer"
    email    "uzer@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end