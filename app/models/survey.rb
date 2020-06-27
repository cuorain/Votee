class Survey < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :question, presence: true, length: {maximum: 256}
  validates :user_id, presence: true
end
