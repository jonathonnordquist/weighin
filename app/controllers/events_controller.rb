class EventsController < ApplicationController
  # Get and return all events
  def index
    @events = Event.all.order(:id)
  end

  # Get and return a specific event
  def show
    @event = Event.find(params[:id])
  end

  # Create a new event object and redirect to people_path
  def create
    @event = Event.create(event_params)
    redirect_to people_path
  end

  private

  # Sanatize params, allow only name and/or tagline
  def event_params
    params.require(:event).permit(:name, :tagline)
  end
end
