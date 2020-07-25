class VotesChoice < ApplicationRecord
  belongs_to :vote
  belongs_to :choice
end
