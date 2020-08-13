class VotesChoice < ApplicationRecord
  belongs_to :vote
  belongs_to :choice
  validates :vote_id, presence: true, :uniqueness => {:scope => :choice_id}
  validates :choice_id, presence: true
end
