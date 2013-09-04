class CreateRomanticMeetings < ActiveRecord::Migration
  def change
    create_table :romantic_meetings do |t|
      t.datetime :start
      t.integer :length
    end
  end
end
