class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  scope :average_by_score, -> (movie_id) { where(movie_id: movie_id).average('score') }

  def self.set_rating(movie_id, user_id)
    rating = Rating.where(movie_id: movie_id, user_id: user_id)
    rating.count == 0 ? Rating.create(movie_id: movie_id, user_id: user_id, score: 0) : rating.first
  end

  def self.average(movie_id)
    ratings = Rating.where('score > 0')
    ratings.where(movie_id: movie_id).average(:score).to_f
  end
end
