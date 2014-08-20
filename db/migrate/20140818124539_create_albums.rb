class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, :length => 250, :null => false
      t.text :description

      t.timestamps
    end
  end
end
