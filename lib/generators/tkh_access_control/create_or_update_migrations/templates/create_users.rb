class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :email
      t.string    :password_digest
      t.string    :first_name
      t.string    :last_name
      t.string    :other_name
      t.string    :auth_token
      t.string    :password_creation_token
      t.datetime  :password_creation_token_sent_at
      t.string    :password_reset_token
      t.datetime  :password_reset_sent_at
      t.boolean   :email_validated,                  default: false
      t.string    :email_validation_token
      t.datetime  :email_validation_token_sent_at

      t.timestamps
    end
    add_index :users, :email
  end
end
