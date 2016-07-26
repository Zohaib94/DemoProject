class Movie < ActiveRecord::Base

  DEFAULT_SEARCH_ORDER = 'updated_at DESC'
  DEFAULT_SEARCH_FILTER = { approved: true }
  GENRES = %w(Action Horror Comedy Thriller Romance Sci-Fi Sports Tragedy Animated)
  MOVIE_TYPES = %w(latest featured)
  RESULTS_PER_PAGE = 8

  paginates_per RESULTS_PER_PAGE

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
    if type_param.in? MOVIE_TYPES
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

  def self.default_search_options(parameters)
    {
      order: DEFAULT_SEARCH_ORDER,
      with: DEFAULT_SEARCH_FILTER,
      conditions: {},
      page: parameters[:page],
      per_page: RESULTS_PER_PAGE
    }
  end

  def self.search_movies(parameters)
    search_options = Movie.default_search_options(parameters)

    search_options[:conditions][:title] = parameters[:title] if parameters[:title].present?
    search_options[:conditions][:genre] = parameters[:genre] if parameters[:genre].present?
    search_options[:conditions][:actor_name] = parameters[:actor_name] if parameters[:actor_name].present?

    search_options[:with][:release_date] = date_range(parameters[:start_date], parameters[:end_date]) if parameters[:start_date].present?

    Movie.search(search_options)
  end

  def self.basic_search(parameters)
    Movie.search(parameters[:search], with: DEFAULT_SEARCH_FILTER, order: DEFAULT_SEARCH_ORDER, page: parameters[:page], per_page: RESULTS_PER_PAGE)
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

  def self.index_movies(params)
    if params[:search].present?
      Movie.basic_search(params)
    elsif params[:type].present?
      Movie.get_movies(params[:type]).page(params[:page])
    else
      Movie.search_movies(params)
    end
  end

end
