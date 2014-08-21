class Photo < ActiveRecord::Base
  belongs_to :album
  
  mount_uploader :image_file, FileUploader

  before_validation :set_title
  before_create :exif_read
  
  private
  
  def set_title
    self.title = self.image_file.file.basename.titleize unless self.title
  end
  

  def exif_read
    path = self.image_file.file.file
    puts "Loading MiniExiftool for " + path
    photo = MiniExiftool.new(path)
    puts "Description: " + photo.ImageDescription.to_s
    puts "Capture time: " + photo.DateTimeOriginal.to_s
    self.longitude = photo.GPSLongitude if self.longitude.nil?
    self.latitude = photo.GPSLatitude if self.latitude.nil?
    self.title = photo.DocumentName if self.title.nil?
    self.description = photo.ImageDescription if self.description.nil? && photo.ImageDescription != 'Exif_JPEG_PICTURE'
    self.capture_time = photo.DateTimeOriginal if self.capture_time.nil?
  end
  
end
