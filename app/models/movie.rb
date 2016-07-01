class Movie < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :description, length: { maximum: 255 }
  validates :trailer_url, length: { maximum: 1000 }
  validates :duration, numericality: { greater_than: -1 }

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :appearances
  has_many :actors, through: :appearances

  accepts_nested_attributes_for :attachments, allow_destroy: true , reject_if: proc { |attributes| attributes['image'].blank? }

  GENRES =  ['Action', 'Horror', 'Comedy']

  def return_image_path
    self.attachments.first ? self.attachments.first.image.url(:medium) : '/download.png'
  end

end
