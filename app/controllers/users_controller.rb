class UsersController < ApplicationController
  before_action :authenticate!

  # list all friends
  def index
    @users = current_user.friends
  end

  # list certain firends
  def show
    @user = User.includes(:subscribed_topics).find_by(nick_name: params[:id])
  end
end
