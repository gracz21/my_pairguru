FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Internet.user_name }
    confirmed_at { Time.zone.now }
    password 'password'

    trait :with_comments do
      transient do
        number_of_comments 3
      end

      after(:create) do |user, evaluator|
        create_list(:comment, evaluator.number_of_comments, user: user)
      end
    end
  end
end