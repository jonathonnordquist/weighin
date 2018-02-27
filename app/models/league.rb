class League < ActiveRecord::Base
  has_many :users

  has_many :league_event_joins
  has_many :events, through: :league_event_joins

  def get_people
    users.map do |user|
      user.people.first
    end
  end
end
