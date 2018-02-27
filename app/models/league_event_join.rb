class LeagueEventJoin < ActiveRecord::Base
  belongs_to :league
  belongs_to :event
end
