class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :edit_password, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user, only: [:edit, :edit_password, :update, :destroy]
  before_action :update_password, only: [:update]
  before_action :not_logged_in_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "アカウント登録が完了しました。"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @title = "ユーザ検索"
    @path = users_path
    @users = User.where(admin: false).page(params[:page]).per(10).search(params[:search])
    render 'users/user_feed'
  end

  def show
    @user = User.find(params[:id])
    @path = user_path(@user)
    @my_surveys = @user.survey.all.page(params[:page_mine]).per(10).search(params[:my_search])
    user_votes = Vote.where("user_id = ?", @user.id)
    user_votes_ids = []
    user_votes.each do |u|
      user_votes_ids << u.survey_id
    end
    @voted_surveys = Survey.where("id IN (?)", user_votes_ids).page(params[:page_voted]).per(10).search(params[:voted_search])
  end

  def edit
    @user = current_user
  end

  def edit_password
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(edit_user_params)
      flash[:success] = "アカウント情報を変更しました。"
      redirect_to root_path
    else
      if request.referer&.include?("/edit_password")
        flash[:danger] = "新しいパスワードは６文字以上かつ、パスワード確認と同じ文字列にしてください。"
        redirect_to request.referer
      else
        render 'edit'
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました。"
    redirect_to root_url
  end

  def following
    @title = "フォロー"
    @path = following_user_path
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10).search(params[:search])
    render 'users/user_feed'
  end

  def followers
    @title = "フォロワー"
    @path = followers_user_path
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10).search(params[:search])
    render 'users/user_feed'
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
        :sex, :birthday, :prefecture_code, :image )
  end

  def edit_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
        :sex, :prefecture_code, :image)
  end

  def current_password_confirmation
    params.require(:user).permit(:current_password)
  end

  def update_password
    if params[:user][:password].blank?
      if request.referer&.include?("/edit_password")
        flash[:danger] = "新しいパスワードを入力してください。"
        redirect_to request.referer
      else
        true
      end
    else
      if @user.authenticate(params[:user][:current_password])
        true
      else
        flash[:danger] = "現在のパスワードが違います。"
        redirect_to request.referer
      end
    end
  end
end
