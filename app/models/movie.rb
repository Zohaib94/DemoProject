class Movie < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :description, length: { maximum: 255 }
  validates :trailer_url, length: { maximum: 1000 }
  validates :duration, numericality: { greater_than: -1 }

  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true , reject_if: proc { |attributes| attributes['image'].blank? }
end
