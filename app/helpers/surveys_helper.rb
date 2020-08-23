module SurveysHelper
  def vote_count(rel, choice)
    vote = rel.where("choice_id = ?", choice.id).count
    return vote
  end

  def is_created?(survey)
    return true if survey.user_id == current_user.id
  end

  def voted_surveys(user)
    user_votes = Vote.where("user_id = ?", user.id)
    user_votes_ids = []
    user_votes.each do |u|
      user_votes_ids << u.survey_id
    end
    return Survey.where("id IN (?)", user_votes_ids).page(params[:page_voted])
          .per(10).search(params[:voted_search])
  end
end
