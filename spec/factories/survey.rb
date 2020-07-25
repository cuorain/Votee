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
end
