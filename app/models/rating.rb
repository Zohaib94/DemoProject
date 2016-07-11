class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
