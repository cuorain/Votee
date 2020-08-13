class VotesController < ApplicationController
  before_action :logged_in_user
  before_action :duplicate_vote, only: :create

  def create
    @new_vote = current_user.vote.build(vote_params)
    unless params[:vote][:choice_ids] == nil
      if params[:vote][:comment].length > 256
        flash[:danger] = "コメントは256文字以内で入力してください。"
        redirect_to request.referer
      else
        if @new_vote.save
          params[:vote][:choice_ids].each do |choice_id|
            VotesChoice.create(vote_id: @new_vote.id, choice_id: choice_id)
          end
          flash[:success] = "投票しました。"
          redirect_to survey_result_path
        else
          log_out
          flash[:danger] = "予期せぬエラーが発生しました。"
          redirect_to root_path
        end
      end
    else
      flash[:danger] = "選択してください。"
      redirect_to request.referer
    end
  end

  def update
    @edit_vote = current_user.vote.find_by(params[:vote_id])
    if @edit_vote
      @edit_vote.destroy
      create
    else
      log_out
      flash[:danger] = "予期せぬエラーが発生しました。"
      redirect_to root_path
    end
  end

  def destroy
    current_user.vote.find_by(params[:vote_id]).destroy
    flash[:success] = "投票を取り消しました"
    redirect_to survey_result_path
  end

private
  def vote_params
    params.require(:vote).permit(:user_id, :survey_id, :comment)
  end

  def duplicate_vote
    survey = Survey.find_by(id: params[:vote][:survey_id])
    if current_user.voted?(survey)
      flash[:danger] = "二重投票はできません。"
      redirect_to root_path
    end
  end
end
