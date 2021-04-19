module ApplicationHelper
  include Pagy::Frontend

  def bootstrap_button_to(label, path, button_classes: {})
    # button_tag(type: 'button', class: "btn #{button_classes}")  do
    #   link_to(label, path)
    # end
    link_to(label, path, class: "btn #{button_classes}", role: 'button')
  end

  def icon_link(link, icon, link_options: {})
    link_to link, link_options do
      content_tag(:span, '', class: icon).html_safe
    end
  end
end
