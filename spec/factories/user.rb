FactoryBot.define do
  factory :new_user, class: User do
    name {"ryohei"}
    email {"abcdefg@gmail.com"}
    password {"foobar"}
    password_confirmation {"foobar"}
    sex {"1"}
    birthday {1990-1-1}
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
    birthday {1990-1-1}
    prefecture_code {10}
  end
end
