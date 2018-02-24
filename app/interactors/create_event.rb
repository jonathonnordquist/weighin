class CreateEvent
  # Call class with name and tagline
  def self.call(name, tagline)
    # Create a new event object with the name and tagline, assign to 'event'
    event = Event.create(name: name, tagline: tagline)
    # Find each person
    Person.find_each do |p|
      # Clear out each persons starting_weight and up_by scores
      p.starting_weight = nil
      p.up_by = nil

      # Save with the wiped records
      p.save
    end
    # Return the new event
    event
  end
end
