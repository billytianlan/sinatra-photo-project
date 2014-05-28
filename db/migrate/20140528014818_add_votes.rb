class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    t.string :photo_id
    t.string :user_id
    t.datetime :created_at
    t.datetime :updated_at
  end
 end
end
