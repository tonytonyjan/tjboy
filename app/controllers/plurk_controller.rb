class PlurkController < ApplicationController
  def sign_in
    consumer = OAuth::Consumer.new(Settings::consumer_key, Settings::consumer_secret, Tjplurk::OAUTH_OPTIONS)
    request_token = consumer.get_request_token(oauth_callback: plurk_callback_url)
    session[:request_token], session[:request_secret] = request_token.token, request_token.secret
    redirect_to request_token.authorize_url
  end

  def callback
    consumer = OAuth::Consumer.new(Settings::consumer_key, Settings::consumer_secret, Tjplurk::OAUTH_OPTIONS)
    request_token = OAuth::RequestToken.new consumer, session[:request_token], session[:request_secret]
    access_token = request_token.get_access_token oauth_verifier: params[:oauth_verifier]
    raw = access_token.get('/APP/Users/me').body
    profile = JSON.parse raw
    if user = User.find_or_create_by(plurk_uid: profile['id'].to_s)
      user.update full_name: profile['full_name'],
                  nick_name: profile['nick_name'],
                  display_name: profile['display_name'],
                  avatar_big: profile['avatar_big'],
                  avatar_small: profile['avatar_small'],
                  avatar_medium: profile['avatar_medium'],
                  token: access_token.token,
                  secret: access_token.secret,
                  raw: raw
      session[:request_token], session[:request_secret] = nil, nil
      session[:user_id] = user.id
      redirect_to root_path, notice: '成功登入'
    else
      redirect_to root_path, alert: '出錯'
    end
  end

  def sign_out
    session[:user_id]
  end
end
