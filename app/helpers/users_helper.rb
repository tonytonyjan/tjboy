module UsersHelper
  # How to render the avatar
  # One needs to construct the avatar URL. user_id specifies user's id while avatar specifies the profile image version.
  # If has_profile_image == 1 and avatar == null then the avatar is:

  # http://avatars.plurk.com/{user_id}-small.gif 
  # http://avatars.plurk.com/{user_id}-medium.gif 
  # http://avatars.plurk.com/{user_id}-big.jpg

  # If has_profile_image == 1 and avatar != null:
  # http://avatars.plurk.com/{user_id}-small{avatar}.gif 
  # http://avatars.plurk.com/{user_id}-medium{avatar}.gif 
  # http://avatars.plurk.com/{user_id}-big{avatar}.jpg

  # If has_profile_image == 0:
  # http://www.plurk.com/static/default_small.gif 
  # http://www.plurk.com/static/default_medium.gif 
  # http://www.plurk.com/static/default_big.gif
  def avatar_url(has_profile_image: , avatar: , plurk_uid: , size: :small)
    if has_profile_image == 1 && avatar == nil
      ext = size == :big ? 'jpg' : 'gif'
      "http://avatars.plurk.com/#{plurk_uid}-#{size}.#{ext}"
    elsif has_profile_image == 1
      ext = size == :big ? 'jpg' : 'gif'
      "http://avatars.plurk.com/#{plurk_uid}-#{size}#{avatar}.#{ext}"
    else
      "http://www.plurk.com/static/default_#{size}.gif"
    end 
  end

  def avatar_for_friend friend
    avatar_url(has_profile_image: friend['has_profile_image'], avatar: friend['avatar'], plurk_uid: friend['id'])
  end
end