module PagesHelper
  def get_attachment_object(resource)
    resource.attachment || Attachment.new
  end

  def sections_exist?(first_section, second_section, third_section)
    first_section || second_section || third_section
  end
end
