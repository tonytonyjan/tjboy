module ApplicationHelper
  def th_for model_class, *attr_names
    attr_names.map{|name| content_tag :th, model_class.human_attribute_name(name) }.inject(&:+)
  end

  def icon_tag name, content=nil
    content_tag :span, content, class: "glyphicon glyphicon-#{name}"
  end

  def user_signed_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def notice_message
    ret = ''.html_safe
    ret += content_tag :div, notice, class: 'alert alert-dismissable alert-success' if notice
    ret += content_tag :div, alert, class: 'alert alert-dismissable alert-danger' if alert
    ret
  end
end
