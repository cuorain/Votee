class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @my_surveys = current_user.survey.all.page(params[:page]).per(10).search(params[:my_search])
      @voted_surveys = Survey.joins(:votes).preload(:votes).all.page(params[:page]).per(10).search(params[:voted_search])
    end
  end

  def about
  end
end
