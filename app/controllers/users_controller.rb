class UsersController < ApplicationController
  before_action :authenticate!

  def search
    # render json: current_user.api.request('/APP/Profile/getPublicProfile', user_id: params[:nick_name])
    if user = User.find_by(nick_name: params[:nick_name])
      redirect_to [user, Topic]
    else
      profile = current_user.api.request('/APP/Profile/getPublicProfile', user_id: params[:nick_name])
      if profile['error_text']
        redirect_to request.referer || root_path, alert: '找不到這個人'
      else
        user = User.create nick_name: profile['user_info']['nick_name'],
          full_name: profile['user_info']['full_name'],
          plurk_uid: profile['user_info']['id'],
          display_name: profile['user_info']['display_name'],
          avatar_big: profile['user_info']['avatar_big'],
          avatar_small: profile['user_info']['avatar_small'],
          avatar_medium: profile['user_info']['avatar_medium']
        redirect_to [user, Topic]
      end 
    end
  end
end
