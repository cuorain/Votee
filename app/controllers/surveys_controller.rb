class SurveysController < ApplicationController
  before_action :logged_in?

  def new
    @survey = Survey.new
  end

  def create
    @survey = current_user.survey.build(survey_params)
    if @survey.save
      flash[:success] = "アンケートを作成しました。"
      redirect_to root_url
    else
      render "new"
    end
  end

private
  def survey_params
    params.require(:survey).permit(:question)
  end
end
