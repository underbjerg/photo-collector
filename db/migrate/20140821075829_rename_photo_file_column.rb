class RenamePhotoFileColumn < ActiveRecord::Migration
  def change
    rename_column :photos, :file, :image_file
  end
end
