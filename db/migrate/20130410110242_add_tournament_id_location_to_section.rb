class AddTournamentIdLocationToSection < ActiveRecord::Migration
  def change
    add_column :sections, :tournament_id, :integer
    add_column :sections, :location, :string
  end
end
