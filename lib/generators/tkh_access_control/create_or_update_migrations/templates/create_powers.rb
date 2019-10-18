class CreatePowers < ActiveRecord::Migration[6.0]
  def change
    create_table :powers do |t|
      t.integer   :user_id
      t.integer   :role_id
      t.timestamps
    end
    add_index :powers, :user_id
  end
end
