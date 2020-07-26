FactoryBot.define do
  factory :survey, class: Survey do
    question {"好きな食べ物は？"}
    association :user
    after(:build) do |survey|
      survey.choices << FactoryBot.build(:choice, answer: "りんご")
      survey.choices << FactoryBot.build(:choice, answer: "ブルーベリー")
      survey.choices << FactoryBot.build(:choice, answer: "バナナ")
      survey.choices << FactoryBot.build(:choice, answer: "みかん")
    end

  end

  factory :other_survey, class: Survey do
    question {"好きなスポーツは？"}
    association :user, factory: :new_user
    after(:build) do |survey|
      survey.choices << FactoryBot.build(:choice, answer: "野球")
      survey.choices << FactoryBot.build(:choice, answer: "サッカー")
      survey.choices << FactoryBot.build(:choice, answer: "テニス")
      survey.choices << FactoryBot.build(:choice, answer: "バスケットボール")
    end
  end

  factory :voted_survey, class: Survey do
    question {"好きなアーティストは？"}
    association :user, factory: :mob_user
    after(:build) do |survey|
      survey.choices << FactoryBot.build(:choice, answer: "あいみょん")
      survey.choices << FactoryBot.build(:choice, answer: "ヨルシカ")
      survey.choices << FactoryBot.build(:choice, answer: "ずっと真夜中でいいのに。")
      survey.choices << FactoryBot.build(:choice, answer: "Aimer")
    end
  end
end
