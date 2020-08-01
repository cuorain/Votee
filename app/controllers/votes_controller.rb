class VotesController < ApplicationController
  before_action :logged_in_user



  def create
    @new_vote = current_user.vote.build(vote_params)
    if params[:vote][:choice_ids] != nil && @new_vote.save
      flash[:success] = "投票しました。"
      redirect_to survey_result_path
    elsif params[:vote][:choice_ids] == nil
      flash[:danger] = "選択してください。"
      redirect_to request.referer
    else
      flash[:danger] = "コメントは256文字以内で入力してください。"
      redirect_to request.referer
    end
  end

  def update
    @edit_vote = current_user.vote.find_by(params[:vote_id])
    if params[:vote][:choice_ids] != nil
      @edit_vote.update_attributes(vote_params)
      flash[:success] = "投票修正しました。"
      redirect_to survey_result_path
    else
      if request.referer&.include?("/surveys")
        flash[:danger] = "選択してください。"
        redirect_to request.referer
      end
    end
  end

  def destroy
    current_user.vote.find_by(params[:vote_id]).destroy
    flash[:success] = "投票を取り消しました"
    redirect_to survey_result_path
  end

private
  def vote_params
    params.require(:vote).permit(:user_id, :survey_id, :comment, {:choice_ids => []})
  end
end
