class CreateSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :slots do |t|
      t.references :vinyl_box, null: false, foreign_key: true

      t.timestamps
    end
  end
end
