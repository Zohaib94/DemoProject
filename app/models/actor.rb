class Actor < ActiveRecord::Base
  has_many :appearances, dependent: :destroy
  has_many :movies, through: :appearances
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true , reject_if: proc { |attributes| attributes['image'].blank? }

  GENDERS =  %w(Male Female)

  validates :first_name, :last_name, :gender, :birth_date, presence: true
  validates :first_name, :last_name, length: { maximum: 30 }
  validates :city, :country, length: { maximum: 20 }
  validates :gender, length: { maximum: 10 }, inclusion: { in: %w(Male Female), message: "%{value} is not valid" }

  def full_name
    [self.first_name, self.last_name].join(' ')
  end
end
