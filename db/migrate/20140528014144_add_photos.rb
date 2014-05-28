class AddPhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    t.string :url
    t.string :description
    t.integer :user_id
    t.datetime :created_at
    t.datetime :updated_at
  end
 end
end