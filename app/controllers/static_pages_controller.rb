class StaticPagesController < ApplicationController
  def home
    if @user = current_user
      @my_surveys = current_user.survey.all.page(params[:page_mine]).per(10).search(params[:my_search])
      @voted_surveys = Survey.joins(:votes).preload(:votes).group(:question).all.page(params[:page_voted]).per(10).search(params[:voted_search])
    end
  end

  def about
  end
end
