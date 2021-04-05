module ApplicationHelper
  def bootstrap_button_to(label, path, button_classes: {})
    # button_tag(type: 'button', class: "btn #{button_classes}")  do
    #   link_to(label, path)
    # end
    link_to(label, path, class: "btn #{button_classes}", role: 'button')
  end
end
