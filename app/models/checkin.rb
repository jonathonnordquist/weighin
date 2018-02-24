class Checkin < ActiveRecord::Base
  # Create associations with Person, Event and User models
  belongs_to :person
  belongs_to :event
  belongs_to :user
end
