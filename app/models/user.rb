class User < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 64}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: {maximum: 256},
      format: { with: VALID_EMAIL_REGEX }

  def self.search(search)
    if search.present?
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end

#パスワードなしで更新できるように
  def update_without_current_password(params, *options)
      params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
