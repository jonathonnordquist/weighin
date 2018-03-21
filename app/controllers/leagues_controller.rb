class LeaguesController < ApplicationController
  def show
    @league = League.find(params[:id])
  end

  def show_event
#     Be more explicit about the id params
#     Didn't index the database
#     N + 1 querying, nested queries, end up calling the query N times with inner query, +1 for the outer query
#     Ruby encourges this, have to be careful about this, learn how to tell AR to preload all the required data in a single query instead of a swarm of them
#     Run the console and be on the lookout for a ton of selects
#     With calculating the weight could have precomputed and stored
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
