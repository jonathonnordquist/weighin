class CreateLeagueEventJoins < ActiveRecord::Migration
  def change
    create_table :league_event_joins do |t|
      t.integer :league_id
      t.integer :event_id

      t.timestamps
    end
  end
end
