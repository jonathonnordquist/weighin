class UserLocationJoin < ActiveRecord::Base
  # Associative entity joining the User and Location models
  belongs_to :user
  belongs_to :location
end
