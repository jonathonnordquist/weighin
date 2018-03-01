class PeopleController < ApplicationController
  # Create a new person
  def create
    # Build a person
    @person = Person.create(person_params)
    # Pass the person with additional info to CreateCheckin interactor
    CreateCheckin.call(@person, Event.last, checkin_params[:weight].to_f, current_user)
    # Redirect back to people_path
    redirect_to people_path
  end

  # Redirect to the new_event_path or render index
  def index
    # Get last event if available
    @event = Event.last
    # If not last event send to new_event_path
    unless @event
      redirect_to new_event_path
    end
  end

  # Return specific person
  def show
    @person = Person.find(params[:id])
  end

  private

  # Sanatize params require person containing only name
  def person_params
    params.required(:person).permit([:name])
  end

  # Sanatize params require person containing only weight
  def checkin_params
    params.required(:person).permit([:weight])
  end
end
