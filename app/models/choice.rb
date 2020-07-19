class Choice < ApplicationRecord
  belongs_to :survey

  validates :answer, presence: true, length: {maximum: 256}
end
