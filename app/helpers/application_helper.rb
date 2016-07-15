module ApplicationHelper
  def button_title(value)
    if action_name == 'new'
      "Create #{value}"
    else
      "Update #{value}"
    end
  end

  def alert_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
    }[flash_type.to_sym] || flash_type.to_s
  end

  def heading(type)
    if type && type.in?(Movie::TYPES)
      type.capitalize
    end
  end

  def display_value(object)
    object.present? && object || 'Not Available'
  end

  def date_display(date)
    if date.present?
      date_array = date.to_s.split('-')
      [date_array[1], date_array[2], date_array[0]].join('-')
    end
  end

end
