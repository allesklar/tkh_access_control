class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|
      t.integer   :role_id
      t.integer   :permission_id
      t.timestamps
    end
    add_index :abilities, :role_id
  end
end
