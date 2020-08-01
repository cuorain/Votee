module TestHelper
  def login(user)
    visit login_path
    fill_in 'メールアドレス', with: 'aiueo@gmail.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン', class: 'btn'
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def vote(survey)
    visit survey_path(survey)
    check match: :first
    fill_in "コメント", with: "最高！"
    click_on "投票", class: "btn"
  end
end
