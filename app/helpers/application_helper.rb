module ApplicationHelper
  def th_for model_class, *attr_names
    attr_names.map{|name| content_tag :th, model_class.human_attribute_name(name) }.inject(&:+)
  end

  def icon_tag name
    content_tag :span, nil, class: "glyphicon glyphicon-#{name}"
  end
end
