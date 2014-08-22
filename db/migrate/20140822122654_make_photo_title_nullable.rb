class MakePhotoTitleNullable < ActiveRecord::Migration
  def change
    change_column :photos, :title, :string, :length => 250, :null => true
  end
end
