FactoryGirl.define do
  factory :comment do
    text Faker::Lorem.sentence
    movie
    user
  end
end
