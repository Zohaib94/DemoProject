class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :attachment, as: :attachable
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :reported_reviews, dependent: :destroy
  has_many :favorite_movies, dependent: :destroy

  accepts_nested_attributes_for :attachment, allow_destroy: true, reject_if: proc { |attributes| attributes['image'].blank? }

  GENDERS =  %w(Male Female)

  validates :first_name, :last_name, presence: true
  validates :gender, inclusion: { in: %w(Male Female), message: "%{value} is not valid" }

  def full_name
    [self.first_name , self.last_name].join(" ")
  end

  def profile_picture_path(style_parameter)
    self.attachment ? self.attachment.image.url(style_parameter) : '/assets/medium/missing.png'
  end

  def has_reported?(review)
    self.reported_reviews.where(review: review).present?
  end

  def get_favorite_movies
    movie_ids = self.favorite_movies.pluck(:movie_id)
    Movie.where(id: movie_ids)
  end

  def has_already_favorite?(movie)
    self.favorite_movies.where(movie: movie).present?
  end
end
