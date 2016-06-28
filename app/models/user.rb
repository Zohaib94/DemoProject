class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :attachment, as: :attachable

  accepts_nested_attributes_for :attachment

  GENDERS =  ['Male', 'Female']

  def full_name
    [self.first_name , self.last_name].join(" ")
  end

  def profile_picture_path(style_parameter)
    self.attachment ? self.attachment.image.url(style_parameter) : '/assets/medium/missing.png'
  end
end
