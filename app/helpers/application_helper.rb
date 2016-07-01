module ApplicationHelper
  def button_title(value)
    if action_name == 'new'
      "Create #{value}"
    else
      "Update #{value}"
    end
  end
end
