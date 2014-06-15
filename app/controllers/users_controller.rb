class UsersController < ApplicationController
  before_action :authenticate!

  # listfriends
  def index
    @users = current_user.friends
  end
end
