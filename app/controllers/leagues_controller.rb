class LeaguesController < ApplicationController
  def show
    binding.pry
    @league = League.find(params[:id])
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
