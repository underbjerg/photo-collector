class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title, :length => 250, :null => false
      t.text :description
      t.integer :album_id
      t.datetime :capture_time
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
