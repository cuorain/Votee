module SurveysHelper
  def vote_count(choice)
    vote = VotesChoice.where("choice_id = ?", choice.id).count
    return vote
  end

  def is_created?(survey)
    return true if survey.user_id == current_user.id
  end
end
