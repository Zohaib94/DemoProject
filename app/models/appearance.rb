class Appearance < ActiveRecord::Base
  belongs_to :movie
  belongs_to :actor
end
