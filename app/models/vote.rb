class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  has_many :votes_choices, dependent: :destroy
  has_many :choices, through: :votes_choices
  accepts_nested_attributes_for :choices, allow_destroy: true
  validates :comment, length: {maximum: 256}

end
