module ApplicationHelper
  def button_title(model_name)
    action_name == 'new' ? "Create #{model_name}" : "Update #{model_name}"
  end

  def alert_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
    }[flash_type.to_sym] || flash_type.to_s
  end

  def display_heading(type)
    if type && type.in?(Movie::TYPES)
      type.capitalize
    end
  end

  def display_value(object)
    object.present? && object || 'Not Available'
  end

  def date_display(date)
    date.strftime('%m-%d-%Y') if date.present?
  end
end
