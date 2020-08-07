#管理ユーザー
User.create!(
  name: "管理者",
  email: "test0@gmail.com",
  password: "foobar",
  admin: true
)
users = []
#初期ユーザ
60.times do |n|
  if n <= 30
    sex = "1"
  elsif n >= 31 && n <= 60
    sex = "2"
  else
    sex = "#{rand(1..2)}"
  end
  random_n = rand(1..2)
  if random_n%2 == 1
    name = Faker::Name.unique.name
  else
    name = Faker::Games::Pokemon.unique.name
  end
  users << User.create!(
      name: name,
      email: "test#{n+1}@gmail.com",
      password: "password",
      sex: sex,
      birthday: Faker::Date.between(from: 80.years.ago, to: 5.years.ago),
      prefecture_code: rand(1..47),
      image: open("#{Rails.root}/db/fixtures/image#{n+1}.png")
  )
end

30.times do |n|
  case n
  when 29
      q = "好きな果物は？"
      a1 = "りんご"
      a2 = "バナナ"
      a3 = "みかん"
      a4 = "キウイ"
    when 28
      q = "好きなアーティストは？"
      a1 = "Official髭男ism"
      a2 = "あいみょん"
      a3 = "菅田将暉"
      a4 = "米津玄師"
    when 27
      q = "好きな男性芸能人は？"
      a1 = "小栗旬"
      a2 = "岡田将生"
      a3 = "福山雅治"
      a4 = "山崎賢人"
    when 26
      q = "好きな女性芸能人は？"
      a1 = "本田翼"
      a2 = "新垣結衣"
      a3 = "長澤まさみ"
      a4 = "吉岡里帆"
    when 25
      q = "好きなお笑い芸人は？"
      a1 = "霜降り明星"
      a2 = "四千頭身"
      a3 = "かまいたち"
      a4 = "EXIT"
    when 24
      q = "やってみたいのはどれ？"
      a1 = "スカイダイビング"
      a2 = "エベレスト登山"
      a3 = "世界一周"
      a4 = "無人島サバイバル"
    when 23
      q = "私への罰ゲームを決めてください"
      a1 = "腕立て１００回"
      a2 = "グランド１０周"
      a3 = "デコピン"
      a4 = "熱々おでん"
    when 22
      q = "ズバリ貯金額は？"
      a1 = "宵越しの金は持たん！"
      a2 = "100万以下"
      a3 = "500万以下"
      a4 = "それ以上"
    when 21
      q = "昨日のXX事件どう思う？"
      a1 = "絶対に許せない。重刑を課して欲しい。"
      a2 = "法に則って裁かれてほしい。"
      a3 = "同情の余地はある。"
      a4 = "許してあげてもいいと思う。"
    when 20
      q = "もし学生時代に戻れたらどうする？"
      a1 = "勉強せずにもっと遊ぶ"
      a2 = "勉強と遊びをバランスよくやる"
      a3 = "とにかく勉強する"
      a4 = "前と変わらずに過ごす"
    when 19
      q = "無人島に持って行くなら？"
      a1 = "ナイフ"
      a2 = "水"
      a3 = "携帯と充電器"
      a4 = "火打ち石"
    when 18
      q = "やるならどれ？"
      a1 = "ギター"
      a2 = "ベース"
      a3 = "ドラム"
      a4 = "ピアノ（キーボード）"
    when 17
      q = "好きなYouTuberは？"
      a1 = "ヒカキン"
      a2 = "はじめしゃちょー"
      a3 = "東海オンエア"
      a4 = "水溜まりボンド"
    when 16
      q = "佐藤●●と山本●●の熱愛についてどう思う？"
      a1 = "応援したい"
      a2 = "とても嬉しい"
      a3 = "とてもショック"
      a4 = "うまくいくはずがない"
    when 15
      q = "おすすめのプログラミング言語は？"
      a1 = "Ruby"
      a2 = "Python"
      a3 = "PHP"
      a4 = "JavaScript"
    when 14
      q = "株を買うならどれ？"
      a1 = "米国株"
      a2 = "国内株"
      a3 = "新興国株"
      a4 = "先進国株"
    when 13
      q = "今年読んだ本は？"
      a1 = "3冊以下"
      a2 = "10冊以下"
      a3 = "30冊未満"
      a4 = "30冊以上"
    when 12
      q = "おすすめの漫画は？"
      a1 = "ONE PIECE"
      a2 = "鬼滅の刃"
      a3 = "僕のヒーローアカデミア"
      a4 = "Dr. STONE"
    when 11
      q = "子供に読ませたい野球漫画は？"
      a1 = "ダイヤのA"
      a2 = "ラストイニング"
      a3 = "おおきく振りかぶって"
      a4 = "メジャー"
    when 10
      q = "【プロ野球】今年優勝するのは？"
      a1 = "中日ドラゴンズ"
      a2 = "中日ドラゴンズに決まってる！"
      a3 = "中日ドラゴンズ以外あり得ない！"
      a4 = "今年もこれからも中日ドラゴンズ"
    when 9
      q = "【サッカー】久保●●はどうなると思う？"
      a1 = "日本サッカーに革命を起こす"
      a2 = "日本をW杯優勝に導く"
      a3 = "いずれバロンドールに選ばれる"
      a4 = "海外で鳴かず飛ばずの選手になる"
    when 8
      q = "好きな映画は？"
      a1 = "ショーシャンクの空に"
      a2 = "ハリーポッター"
      a3 = "アベンジャーズ"
      a4 = "スターウォーズ"
    when 7
      q = "車に求めるものは？"
      a1 = "価格の安さ"
      a2 = "外観・内装デザイン"
      a3 = "安全性"
      a4 = "運転しやすさ"
    else
      q = "好きなポケモンは？(PART#{n})"
      a1 = Faker::Games::Pokemon.name
      a2 = Faker::Games::Pokemon.name
      a3 = Faker::Games::Pokemon.name
      a4 = Faker::Games::Pokemon.name
  end
  users[n].survey.create!(
    question: q,
    choices_attributes: [
      {answer: a1},
      {answer: a2},
      {answer: a3},
      {answer: a4}
    ])
end

users.each do |user|
  25.times do |n|
    survey = Survey.all[rand(0..29)]
    user.vote.create!(
      survey_id: survey.id,
      choice_ids: survey.choices.all[rand(0..3)].id
    )
  end
end
