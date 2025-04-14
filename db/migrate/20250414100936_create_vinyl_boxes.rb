class CreateVinylBoxes < ActiveRecord::Migration[7.1]
  def change
    create_table :vinyl_boxes do |t|
      t.integer :capacity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
