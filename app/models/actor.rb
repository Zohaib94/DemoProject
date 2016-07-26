class Actor < ActiveRecord::Base
  has_many :appearances, dependent: :destroy
  has_many :movies, through: :appearances

  GENDERS =  %w(Male Female)

  validates :first_name, :last_name, :gender, :birth_date, presence: true
  validates :gender, inclusion: { in: %w(Male Female), message: "%{value} is not valid" }


  def name
    [self.first_name, self.last_name].join(' ')
  end
end
