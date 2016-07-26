class Movie < ActiveRecord::Base

  DEFAULT_SEARCH_ORDER = 'updated_at DESC'
  GENRES = %w(Action Horror Comedy Thriller Romance Sci-Fi Sports Tragedy Animated)
  TYPES = %w(latest featured)

  paginates_per 12

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :description, length: { maximum: 255 }
  validates :trailer_url, length: { maximum: 1000 }
  validates :duration, numericality: { greater_than_or_equal_to: 0 }

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :appearances, dependent: :destroy
  has_many :actors, through: :appearances
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favorite_movies, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true , reject_if: proc { |attributes| attributes['image'].blank? }

  scope :latest, -> { order(release_date: :desc) }
  scope :approved, -> { where(approved: true) }
  scope :featured, -> { where(featured: true).order(updated_at: :desc) }
  scope :top, -> { joins(:ratings).where('movies.approved = true').group('movie_id').order('avg(ratings.score) desc') }
  scope :waiting_for_approval, -> { where(approved: false) }


  def image_path
    first_attachment = attachments.first
    first_attachment ? first_attachment.image.url(:medium) : 'medium/missing.png'
  end

  def self.get_movies(type_param)
    if type_param.in? TYPES
      type_param == "latest" ? self.approved.latest : self.approved.featured
    else
      self.approved.all
    end
  end

  def display_actors
    self.actors.collect(&:name).join(',')
  end

  def has_favorite?(user)
    self.favorite_movies.where(user: user).present?
  end

  def self.search_movies(parameters)
    default_conditions = {}
    default_conditions[:title] = parameters[:title] if parameters[:title].present?
    default_conditions[:genre] = parameters[:genre] if parameters[:genre].present?
    default_conditions[:actor_name] = parameters[:actor_name] if parameters[:actor_name].present?

    search_filter = { approved: true }
    search_filter[:release_date] = date_range(parameters[:start_date], parameters[:end_date]) if parameters[:start_date].present?

    Movie.search(conditions: default_conditions, with: search_filter, order: DEFAULT_SEARCH_ORDER)
  end

  def self.basic_search(parameters)
    search_filter = { approved: true }
    Movie.search(parameters[:search], with: search_filter, order: DEFAULT_SEARCH_ORDER)
  end

  def movie_hash
    {
      movie_details: self,
      actors: self.actors.pluck(:id, :first_name, :last_name, :gender),
      reviews: self.reviews.pluck(:id, :comment)
    }
  end

  def self.date_range(start_date, end_date)
    if start_date.present? && end_date.present?
     validate_date(start_date)..validate_date(end_date)
    elsif start_date.present?
     validate_date(start_date)..Date.today
    end
  end

  def self.validate_date(date)
    begin
      Date.parse(date)
    rescue
      Date.today
    end
  end

end
