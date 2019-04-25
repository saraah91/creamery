class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.integer :assignment_id
      t.date :date
      t.datetime :start_time
      t.datetime :end_time
      t.text :notes

      t.timestamps
    end
  end
end
