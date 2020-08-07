FactoryBot.define do
  factory :new_user, class: User do
    name {"ryohei"}
    email {"abcdefg@gmail.com"}
    password {"foobar"}
    password_confirmation {"foobar"}
    sex {"1"}
    birthday {"1990-10-10"}
    prefecture_code {1}

    trait :invalid do
      name {" "}
    end

    trait :invalid_confirmation do
      password_confirmation {"aaaaaa"}
    end
  end

  factory :user, class: User do
    name {"nobita"}
    email {"aiueo@gmail.com"}
    password {"password"}
    password_confirmation {"password"}
    sex {"1"}
    birthday {"1990-01-01"}
    prefecture_code {10}
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/factories/test_image.jpg"))}

  end

  factory :other, class: User do
    name {"doraemon"}
    email {"dokodemo@gmail.com"}
    password {"password"}
    password_confirmation {"password"}
    sex {"1"}
    birthday {"1990-10-01"}
    prefecture_code {10}
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/factories/test_image.jpg"))}
  end

  factory :admin, class: User do
    name {"admin"}
    email {"admin@gmail.com"}
    password {"password"}
    password_confirmation {"password"}
    admin {true}
  end

  factory :mob_user, class: User do
    sequence(:name) {|n| "test#{n}"}
    sequence(:email) {|n| "test#{n}@gmail.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
