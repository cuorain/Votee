module SurveysHelper
  def vote_count(choice)
    vote = VotesChoice.where("choice_id = ?", choice.id).count
    return vote
  end
end
