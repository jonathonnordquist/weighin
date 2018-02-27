class League < ActiveRecord::Base
  has_many :users

  def get_people
    users.map do |user|
      user.people.first
    end
  end
end
