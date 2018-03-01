# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'csv'
require 'pry'

weighins_csv_text = File.read(Rails.root.join('weighins.csv'))
participants_csv_text = File.read(Rails.root.join('participants.csv'))
weighins_csv = CSV.parse(weighins_csv_text, headers: true, encoding: 'ISO-8859-1')
participants_csv = CSV.parse(participants_csv_text, headers: true, encoding: 'ISO-8859-1')
current_event = ''

weighins_csv.each do |row|
  if current_event != row['Event']
    new_event = true
    current_event = row['Event']
  end

  @event = Event.find_by(name: row['Event']) || Event.create(name: row['Event'])

  name = row['Name']
  @person = new_event || !@event.people.find_by(name: name) ? Person.create(name: name, starting_weight: row['weight']) : @person = Person.find_by(name: name)

  if !Person.where(name: row['Name']).first.users.count.positive?
    @user = User.new
    @user.email = Faker::Internet.email
    @user.password = 'ababab'
    @user.password_confirmation = 'ababab'
    @user.save!
    @person.user_person_joins.create(user_id: @user.id, person_id: @person.id)
  elsif !@person.users.count.positive?
    @user = Person.where(name: row['Name']).first.users.first
    @person.user_person_joins.create(user_id: @user.id, person_id: @person.id)
  else
    @user = @person.users[0]
  end

  CreateCheckin.call(@person, @event, row['Weight'].to_i, @user)
end

participants_csv.each do |row|
  league = League.find_or_create_by(name: row['League'])
  name = row['Name']
  Person.find_by(name: name).users[0].update_attributes! league_id: league.id unless Person.find_by(name: name).users[0].league_id
  event = Events.where(name: row['Event']).first
  LeagueEventJoins.find_or_create_by(league_id: league.id, event_id: event.id)
end
