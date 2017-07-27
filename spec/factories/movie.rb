FactoryGirl.define do
  factory :movie do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3, true) }
    released_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    genre

    trait :with_comments do
      transient do
        number_of_comments 3
      end

      after(:create) do |movie, evaluator|
        create_list(:comment, evaluator.number_of_comments, movie: movie)
      end
    end
  end
end
