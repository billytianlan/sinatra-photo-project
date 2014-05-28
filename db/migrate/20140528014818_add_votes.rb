class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    t.integer :photo_id
    t.integer :user_id
    t.datetime :created_at
    t.datetime :updated_at
  end
 end
end
