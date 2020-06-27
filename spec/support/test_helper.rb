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
end
