class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @my_surveys = current_user.survey.all.page(params[:page_mine]).per(10).search(params[:my_search])
      user_votes = Vote.where("user_id = ?", @user.id)
      user_votes_ids = []
      user_votes.each do |u|
        user_votes_ids << u.survey_id
      end
      @voted_surveys = Survey.where("id IN (?)", user_votes_ids).page(params[:page_voted]).per(10).search(params[:voted_search])
    end
  end

  def about
  end
end
