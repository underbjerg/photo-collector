class AddSequenceToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :sequence, :integer
  end
end
