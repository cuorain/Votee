require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before(:each) do
    @user = create(:user)
    @other = create(:other)
  end

  example "正しいパラメ" do
    @follow = Relationship.new(follower_id: @user, followed_id: @other)
    expect(@follow.invalid?).to eq true
  end

  example "フォロー相手がいない" do
    @follow = Relationship.new(follower_id: @user)
    expect(@follow.invalid?).to eq true
  end
end
