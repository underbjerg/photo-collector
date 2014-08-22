class FixImageProcessed < ActiveRecord::Migration
  def up
    Photo.all.each do |photo|
      photo.update_column(:image_processed, true)
    end
  end
  
  def down
    
  end
end
