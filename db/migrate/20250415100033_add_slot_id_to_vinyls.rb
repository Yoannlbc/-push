class AddSlotIdToVinyls < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyls, :slot_id, :integer
    add_index :vinyls, :slot_id
  end
end
