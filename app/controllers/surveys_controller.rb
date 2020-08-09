class SurveysController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :my_survey, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

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

  def my_survey
    @surveys = current_user.survey.all.page(params[:page]).per(10).search(params[:search])
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

  def edit
    @survey = Survey.find(params[:id])
  end

  def results
    @params = search_params
    @result_params = ResultParameter.new(search_params).define_params
    @survey = Survey.find(params[:id])
    @choices = @survey.choices.all
    all_votes = @survey.votes
    filtered_user = User.search_users(@result_params)
    @votes = Vote.joins(:user).where("votes.id IN (?) AND user_id IN (?)",
              all_votes.ids, filtered_user.ids)
    @filtered_rel = VotesChoice.joins(:choice).where("vote_id IN (?)", @votes.ids)
    @chart = @filtered_rel.group(:answer).count
  end

  def search_reset
    results
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(survey_params)
      flash[:success] = "アンケートを編集しました。"
      redirect_to survey_path(@survey)
    else
      render "edit"
    end
  end

  def destroy
    Survey.find_by(params[:survey_id]).destroy
    flash[:success] = "アンケートを削除しました。"
    redirect_to surveys_path
  end

private

  def survey_params
    params.require(:survey).permit(:question, choices_attributes:[:id, :answer, :_destroy])
  end

  def search_params
    params.fetch(:search, {}).permit(:sex, :max_age, :mini_age, {:prefecture_code => []})
  end
end
