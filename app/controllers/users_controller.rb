class UsersController < ApplicationController
  before_action :authenticate!

  # list friends
  def index
    if current_user.friends_cache_updated_at.nil? || current_user.friends_cache_updated_at < 1.day.ago
      @friends = get_all_friends_recursively
      current_user.update(friends_cache: @friends.to_json) && current_user.touch(:friends_cache_updated_at)
    else
      @friends = JSON.parse(current_user.friends_cache)
    end
  end

  def search
    # render json: current_user.api.request('/APP/Profile/getPublicProfile', user_id: params[:nick_name])
    if user = User.find_by(nick_name: params[:nick_name])
      redirect_to [user, Topic]
    else
      profile = current_user.api.request('/APP/Profile/getPublicProfile', user_id: params[:nick_name])
      if profile['error_text']
        if profile['error_text'].start_with?('40106')
          session[:previous_url] = request.original_url
          redirect_to sign_in_path
        else
          redirect_to request.referer || root_path, alert: '找不到這個人'
        end
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

  private

  def get_friends_by_offset offset=0
    result = current_user.api.request '/APP/FriendsFans/getFriendsByOffset', user_id: current_user.plurk_uid, limit: 1000, offset: offset.to_i
    if result.is_a?(Hash) && result['error_text']
      if result['error_text'].start_with?('40106')
        session[:previous_url] = request.original_url
        redirect_to sign_in_path
      else
        redirect_to request.referer || root_path, alert: "出錯了：#{result['error_text']}"
      end
    else
      result
    end
  end

  def get_all_friends_recursively friends=[], offset=0
    result = get_friends_by_offset(offset)
    return friends if result.empty?
    friends += result
    get_all_friends_recursively(friends, friends.length)
  end
end
