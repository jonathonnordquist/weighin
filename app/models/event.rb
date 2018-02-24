class Event < ActiveRecord::Base
  # Sets default for all queries to order results based on ascending date of creation
  default_scope { order(created_at: :asc) }

  # Create association with Checkin model
  has_many :checkins
  # Create association with Person model via checkins, setting all queries to return
  # unique records by default
  has_many :people, -> { distinct }, through: :checkins
end
