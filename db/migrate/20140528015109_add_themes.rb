class AddThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
    t.string :name
    t.string :photo_id
    t.datetime :created_at
    t.datetime :updated_at
  end
  end
end
