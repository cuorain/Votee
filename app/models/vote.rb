class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  has_many :votes_choices, dependent: :destroy
  has_many :choices, through: :votes_choices
  validates :comment, length: {maximum: 256}

end
