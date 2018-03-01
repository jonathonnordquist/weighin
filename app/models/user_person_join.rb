class UserPersonJoin < ActiveRecord::Base
  # Associative entity joining the User and Person models
  belongs_to :user
  belongs_to :person
end
