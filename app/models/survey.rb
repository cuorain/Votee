class Survey < ApplicationRecord
  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :votes, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true
  default_scope -> { order(created_at: :desc) }

  validates :question, presence: true, length: {maximum: 256}

  def self.search(search)
    if search.present?
      where(['question LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end
