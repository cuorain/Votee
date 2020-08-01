class VotesChoice < ApplicationRecord
  belongs_to :vote
  belongs_to :choice
  validates :vote_id, :uniqueness => {:scope => :choice_id}
end
