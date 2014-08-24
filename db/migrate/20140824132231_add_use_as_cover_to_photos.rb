class AddUseAsCoverToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :use_as_cover, :boolean, :null => false, :default => false
  end
end
