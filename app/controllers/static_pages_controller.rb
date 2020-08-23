class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @path = root_path
      @user = current_user
      #自分の作ったアンケートたち
      @my_surveys = current_user.survey.all.page(params[:page_mine]).per(10).search(params[:my_search])
      #参加しているアンケートたち
      #自分の投票(vote)のsurvey_idを抽出して配列に変換、アンケートを抽出
      # user_votes = Vote.where("user_id = ?", @user.id)
      # user_votes_ids = []
      # user_votes.each do |u|
      #   user_votes_ids << u.survey_id
      # end
      # @voted_surveys = Survey.where("id IN (?)", user_votes_ids).page(params[:page_voted]).per(10).search(params[:voted_search])
      @voted_surveys = voted_surveys(@user)
    end
  end

  def about
  end
end
