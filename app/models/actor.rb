class Actor < ActiveRecord::Base
  has_many :appearances
  has_many :movies, through: :appearances

  def name
    [self.first_name, self.last_name].join(' ')
  end
end
