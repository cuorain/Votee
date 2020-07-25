class SurveysController < ApplicationController
  before_action :logged_in?

  def new
    @survey = current_user.survey.new
    @survey.choices.build
  end

  def create
    @survey = current_user.survey.new(survey_params)
    if @survey.save
      flash[:success] = "アンケートを作成しました。"
      redirect_to root_url
    else
      render "new"
    end
  end

  def index
    @surveys = Survey.all.page(params[:page]).per(10).search(params[:search])
  end

  def show
    @survey = Survey.find(params[:id])
    @choices = @survey.choices.all
    if current_user.voted?(@survey)
      @edit_vote = current_user.vote.find_by(survey_id: @survey.id)
    else
      @new_vote = current_user.vote.build
    end
  end

  def results
    @survey = Survey.find(params[:id])
    @choices = @survey.choices.all
  end

private

  def survey_params
    params.require(:survey).permit(:question, choices_attributes:[:id, :answer, :_destroy])
  end
end
