class EventDecorator < Draper::Decorator
  delegate_all

  def people_by_ranking
    people.sort_by { |a| a.up_by(self).to_i }.reverse
  end
end
