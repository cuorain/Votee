class User < ApplicationRecord
#関係
  has_many :survey, dependent: :destroy
  has_many :vote, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "followed_id",
                                 dependent:   :destroy
has_many :following, through: :active_relationships,  source: :followed
has_many :followers, through: :passive_relationships, source: :follower
#gem関係
  include JpPrefecture
  jp_prefecture :prefecture_code
  mount_uploader :image, ImageUploader
#セッションのための設定
  attr_accessor :remember_token
#ビフォアアクション系
  before_save {self.email = email.downcase}
# バリデーション
  validates :name, presence: true, length: {maximum: 64}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 256},
      format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続的セッションで使用するユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.search(search)
    if search.present?
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def voted?(survey)
    if self.vote.find_by(survey_id: survey.id) == nil
      false
    else
      true
    end
  end

  def maked_survey?(survey)
    if survey.user_id == self.id
      true
    else
      false
    end
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.search_users(params)
    self.where("sex IN (?) AND
                birthday BETWEEN ? AND ? AND
                prefecture_code IN (?)",
                params[:sex], params[:older_birthday],
                params[:elder_birthday], params[:prefecture_code])
  end
end
