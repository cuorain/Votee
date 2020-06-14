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
end
