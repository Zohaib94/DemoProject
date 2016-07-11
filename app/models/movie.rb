class Movie < ActiveRecord::Base
  paginates_per 12
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :description, length: { maximum: 255 }
  validates :trailer_url, length: { maximum: 1000 }
  validates :duration, numericality: { greater_than: -1 }

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :appearances, dependent: :destroy
  has_many :actors, through: :appearances
  has_many :reviews

  accepts_nested_attributes_for :attachments, allow_destroy: true , reject_if: proc { |attributes| attributes['image'].blank? }

  GENRES = %w(Action Horror Comedy Thriller Romance Sci-Fi Sports Tragedy Animated)

  TYPES = %w(latest featured)

  scope :latest, -> { order(release_date: :desc) }
  scope :approved, -> { where(approved: true) }
  scope :featured, -> { where(featured: true) }

  def return_image_path
    self.attachments.first ? self.attachments.first.image.url(:medium) : '/download.png'
  end

  def self.get_movies(type_param)
    if type_param.in? TYPES
      type_param == "latest" ? self.approved.latest : self.approved.featured
    else
      self.all
    end
  end

end
