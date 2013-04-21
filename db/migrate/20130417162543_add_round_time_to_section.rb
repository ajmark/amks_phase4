class AddRoundTimeToSection < ActiveRecord::Migration
  def change
    add_column :sections, :round_time, :time
  end
end
