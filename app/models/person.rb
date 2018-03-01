class Person < ActiveRecord::Base

  # Create association with Checkin model
  has_many :checkins
  # Create association with User model via user_person_joins
  has_many :user_person_joins
  has_many :users, through: :user_person_joins

  def up_by(event = nil)
    return attributes['up_by'] unless event
    # Get all the checkins for the person and order by creation time
    checkins_from_event = event.checkins.where(person: self).order(:created_at)
    # Get the oldest and newest checkins
    first_checkin = checkins_from_event.first
    last_checkin = checkins_from_event.last
    # If the weights are different return the difference, otherwise return nil
    last_checkin == first_checkin ? nil : last_checkin.weight - first_checkin.weight
  end

  def percentage_change
    # Quit if there isn't a return from up_by
    return unless up_by
    # Calculate the perecent change taking the starting weight, dividing it into the
    # weight change and multiplying by 100
    @percentage_change ||= starting_weight ? up_by.to_f / starting_weight * 100 : nil
  end

  def checkin_diffs
    # Get all checkins that have an event, order by the event created at date
    # and group by event.
    grouped = checkins.includes(:event).order('events.created_at').group_by(&:event)
    event_diffs = {}
    # Go through each entry in the grouped hash, take the key 'event_checkins,' sort it
    # by creation date, map it by the proc on delta and remove any nils.  Then add the
    # collection of event diffs thus generated to the event_diffs hash, using the event
    # name as a key and mapping the diffs collection to 2 decimal floats
    grouped.each_pair do |event, event_checkins|
      diffs = event_checkins.sort_by(&:created_at).map(&:delta).compact
      event_diffs[event.try(:name)] = diffs.map { |d| '%.2f' % d }
    end
    event_diffs
  end

  def league
    users[0].league
  end
end
