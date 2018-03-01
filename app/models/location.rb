class Location < ActiveRecord::Base
  # Create association with User model via user_location_joins
  has_many :user_location_joins
  has_many :users, through: :user_location_joins
end
