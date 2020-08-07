require 'rails_helper'

RSpec.describe VotesChoice, type: :model do
  context "二重投票禁止" do
    example "バリデーション" do
      @vote = VotesChoice.new(vote_id: 1, choice_id: 1)
      @dup_vote = VotesChoice.new(vote_id: 1, choice_id: 1)
      expect(@dup_vote.valid?).to eq false
    end
  end
end
