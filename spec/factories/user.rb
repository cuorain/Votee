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
  end
end
