class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string :username
    t.string :password
    t.string :email
    t.datetime :created_at
    t.datetime :updated_at
  end
 end
end
