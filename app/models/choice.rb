class Choice < ApplicationRecord
  belongs_to :survey
  has_many :votes_choices, dependent: :destroy
  has_many :votes, through: :votes_choices, dependent: :destroy
  validates :answer, presence: true, length: {maximum: 256}
end
