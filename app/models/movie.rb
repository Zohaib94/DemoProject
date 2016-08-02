class Movie < ActiveRecord::Base

  GENRES = %w(Action Horror Comedy Thriller Romance Sci-Fi Sports Tragedy Animated)
  MOVIE_TYPES = %w(latest featured all)
  RESULTS_PER_PAGE = 8
  ORDERING_FIELDS = %w(rating release)
  ORDERS = %w(ascending descending)

  paginates_per RESULTS_PER_PAGE

  validates :title, :description, :release_date, :trailer_url, presence: true
  validates :title, uniqueness: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :genre, length: { maximum: 20 }
  validates :duration, length: { maximum: 5 }
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
  scope :top, -> { joins(:ratings).where('movies.approved = true AND ratings.score > 0').group('movies.id').order('avg(ratings.score) desc') }
  scope :waiting_for_approval, -> { where(approved: false) }
  scope :oldest, -> { order(release_date: :asc) }
  scope :lowest_rated, -> { joins(:ratings).where('movies.approved = true AND ratings.score > 0').group('movies.id').order('avg(ratings.score) asc') }

  def image_path
    first_attachment = attachments.first
    first_attachment ? first_attachment.image.url(:medium) : 'medium/missing.png'
  end

  def self.get_movies(type_param)
    if type_param.in? MOVIE_TYPES
      movies = self.approved.latest if type_param == 'latest'
      movies = self.approved.featured if type_param == 'featured'
      movies = self.approved.all if type_param == 'all'
    else
      movies = self.approved.all
    end
    movies
  end

  def display_actors
    self.actors.collect(&:full_name).join(',')
  end

  def has_favorite?(user)
    self.favorite_movies.where(user: user).present?
  end

  def self.default_search_options(parameters)
    {
      order: 'updated_at DESC',
      with: { approved: true },
      conditions: {},
      sql: { include: [:attachments] },
      page: parameters[:page],
      per_page: RESULTS_PER_PAGE
    }
  end

  def self.search_movies(parameters)
    search_options = Movie.default_search_options(parameters)

    search_options[:conditions][:title] = serialize_query_string(parameters[:title]) if parameters[:title].present?
    search_options[:conditions][:genre] = serialize_query_string(parameters[:genre]) if parameters[:genre].present?
    search_options[:conditions][:actor_name] = serialize_query_string(parameters[:actor_name]) if parameters[:actor_name].present?

    search_options[:with][:release_date] = date_range(parameters[:start_date], parameters[:end_date]) if parameters[:start_date].present?

    Movie.search(search_options)
  end

  def self.basic_search(parameters)
    Movie.search(serialize_query_string(parameters[:search]), with: { approved: true }, order: 'updated_at DESC', page: parameters[:page], per_page: RESULTS_PER_PAGE, sql: { include: [:attachments] })
  end

  def movie_hash(base_url)
    movie_attachments = []

    attachments.each do |attachment|
      movie_attachments << [base_url, attachment.image.url(:medium)].join
    end

    {
      movie_details: self,
      actors: actors.pluck(:id, :first_name, :last_name, :gender),
      reviews: reviews.pluck(:id, :comment),
      attachments: movie_attachments
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
      Movie.includes(:attachments).get_movies(params[:type]).page(params[:page])
    else
      Movie.search_movies(params)
    end
  end

  def self.order_movies(params)
    if params[:ordering_field].present? && params[:order].present?
      sorted_movies = Movie.oldest if params[:ordering_field] == 'release' && params[:order] == 'ascending'
      sorted_movies = Movie.latest if params[:ordering_field] == 'release' && params[:order] == 'descending'
      sorted_movies = Movie.top if params[:ordering_field] == 'rating' && params[:order] == 'descending'
      sorted_movies = Movie.lowest_rated if params[:ordering_field] == 'rating' && params[:order] == 'ascending'
    else
      sorted_movies = Movie.all
    end
    sorted_movies
  end

  def self.serialize_query_string(string)
    string.gsub(/[^0-9A-Za-z ]/, '')
  end

end
