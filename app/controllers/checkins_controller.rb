class CheckinsController < ApplicationController
  # Make a new checkin record
  def create
    # Get the person doing checkin
    person = Person.find(checkin_params[:person_id])
    # Build a new checin record and save it using the CreateChekin interactor
    @checkin = CreateCheckin.call(person, Event.last, checkin_params[:weight].to_f, current_user)
    # Send the user back to the people_path
    redirect_to people_path
  rescue
    # If there's an error set the flash message
    flash[:error] = "Please fill out all fields"
    # Send the user back to the people_path
    redirect_to new_checkin_path
  end

  # Get all person objects and render
  def new
    @people = Person.all.order(:name)
  end

  private
  # Sanatize params, must have checkin containing only weight and/or person_id
  def checkin_params
    params.require(:checkin).permit(:weight, :person_id)
  end
end
