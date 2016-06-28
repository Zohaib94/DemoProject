module PagesHelper
  def get_attachment_object(resource)
    resource.attachment || Attachment.new
  end
end
