FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'

    factory :downloader do
      email 'downloader@example.com'
    end

    factory :depositor do
      email 'depositor@example.com'
    end

    factory :moderator do
      email 'moderator@example.com'
    end

    factory :admin do
      email 'admin@example.com'
    end

  end
end

