module ApplicationHelper
  def th_for model_class, *attr_names
    attr_names.map{|name| content_tag :th, model_class.human_attribute_name(name) }.inject(&:+)
  end

  def icon_tag name, content=nil
    content_tag :span, content, class: "glyphicon glyphicon-#{name}"
  end

  def notice_message
    ret = ''.html_safe
    ret += content_tag :div, notice, class: 'alert alert-dismissable alert-success' if notice
    ret += content_tag :div, alert, class: 'alert alert-dismissable alert-danger' if alert
    ret
  end

  def nav_li text, url, match: url, method: :start_with?, **link_to_options
    content_tag :li, class: (:active if request.path.send(method, match)) do
      link_to text, url, **link_to_options
    end
  end

  def active_class url, match: polymorphic_path(url), method: :start_with?
    :active if request.path.send(method, match)
  end

  def display_user user
    user ? image_tag(user.avatar_small) + ' ' + user.display_name : ''
  end
end
