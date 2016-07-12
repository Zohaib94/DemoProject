class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  def self.set_rating(movie_id, user_id)
    rating = Rating.where(movie_id: movie_id, user_id: user_id)
    unless rating.count == 0
      rating.first
    else
      Rating.create(score: 0)
    end
  end

  def self.average(movie_id)
    Rating.where(movie_id: movie_id).average(:score).to_f
  end
end
