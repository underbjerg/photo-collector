class AddPathToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :path, :string
  end
end
