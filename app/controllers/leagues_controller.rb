class LeaguesController < ApplicationController
  def show
    @league = League.find(params[:id])
  end

  def show_event
    @event = Event.find(params[:lid])
    @league = League.find(params[:lid])
    event_people_names = @event.people.map(&:name)
    @people = @league.get_people.select { |p| event_people_names.include?(p.name) }
  end

  def create
    @league = League.create(league_params)
    redirect_to leagues_path
  end

  def index
    @leagues = League.all
  end

  private

  def league_params
    params.require(:league).permit(:name)
  end
end
