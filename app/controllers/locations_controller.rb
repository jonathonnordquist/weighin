class LocationsController < ApplicationController
  # Make a new location
  def create
    # Create and save location object, redirec to new_checkin_path
    @location = Location.create(location_params)
    redirect_to new_checkin_path
  end

  # Return all locations
  def index
    @locations = Location.all
  end

  # Return specific location
  def show
    @location = Location.find(params[:id])
  end

  private

  # Sanatize params allow only name
  def location_params
    params.required(:location).permit([:name])
  end
end
