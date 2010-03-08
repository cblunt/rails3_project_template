class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email_address
      t.string :password_hash
      t.string :password_salt
      t.datetime :verified_at
      t.string :verification_key
      t.boolean :admin, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
