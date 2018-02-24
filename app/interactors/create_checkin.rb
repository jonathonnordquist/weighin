class CreateCheckin

  def self.call(person, event, weight, current_user)
    # Do nothigng if in QUIET_MODE environment
    return if ENV['QUIET_MODE']
    # Get all people for an event, sort by their up_by value each persons up_by value
    # or negative 1000 if they don't have one, get the last and therefors 'most up' person
    previously_in_first = event.people.sort_by{|p| p.up_by || -1000 }.last

    # Get the last checkin for this person
    previous_checkin = Checkin.where(person: person, event: event).first
    # Set delta (change) to nil
    delta = nil
    # Set delta to to their weight minus perevious checkin if they've checked in before
    delta = weight - previous_checkin.weight if previous_checkin
    # Create a new checkin with the person, event, weight, change and person making the checkin
    Checkin.create(person: person, event: event, weight: weight, delta: delta, user: current_user)
    # If the person has a starting weight
    if person.starting_weight
      #  update their up_by value using that
      person.up_by = weight - person.starting_weight
      # Else no starting weight means first checkin, set their starting_weight to the input weight
    else
      person.starting_weight = weight
    end
    # Save the person as such
    person.save

    # Check the current user exists and that the current user is not in the people list
    if current_user && !current_user.people.include?(person)
      # Create the current user as a person in the user_persons_joins table
      current_user.user_person_joins.create(person: person)
    elsif current_user && current_user.people.include?(person)
      # Otherwise find the person in the user_persons_joins table
      join = current_user.user_person_joins.find_by(person: person)
      # Increment that value by 1
      join.times_used += 1
      # Save the update
      join.save
    end
  end
end
