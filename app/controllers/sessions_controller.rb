class SessionsController < ApplicationController
  before_action :not_logged_in_user, only: [:new, :create, :demo_login]

  def new
  end

  #ログイン
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      #セッション保持するかどうか
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success] = "ログインしました。"
      redirect_back_or root_path
    else
      flash.now[:danger] = "メールアドレスかパスワードが違います"
      render 'new'
    end
  end

  #簡単ログイン（初期データ１０人からランダムにログイン）
  def demo_login
    @user = User.find_by(email: "test#{rand(1..10)}@gmail.com")
    if @user
      log_in @user
      flash[:success] = "ログインしました。"
      redirect_back_or root_path
    #初期データ登録できてない時や予期せぬエラーに備えて
    else
      flash[:danger] = "デモ用ユーザが登録されていません"
      redirect_to signup_path
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
