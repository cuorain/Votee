module VotesHelper

  def voted_user(vote)
    User.find(vote.user_id)
  end

  def voted_choice(vote)
    relation = VotesChoice.where("vote_id = ?", vote.id)
    relation_id = []
    relation.each do |r|
      relation_id << r.choice_id
    end
    choices = Choice.where("id IN (?)", relation_id)
    answer = []
    choices.each do |c|
      answer << c.answer
    end
    return answer.join
  end
end
