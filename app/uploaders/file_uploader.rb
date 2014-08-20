# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  
  # Choose what kind of storage to use for this uploader:
  # This should be configured in initializers/carrierwave.rb
  # storage :file
  # storage :fog
  
  process :auto_orient
  
  process :store_dimensions

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    #ENV['STORAGE_PATH']
    "uploads" + "/files/#{model.album.path}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :single do
    process :resize_to_limit => [1280, 1024]
    def store_dir
      #ENV['STORAGE_PATH']
      "uploads" + "/thumbs/#{model.album.path}/#{model.id}"
    end
  end
  version :thumb, :from_version => :single do
    process :resize_to_fit => [240, 240]
    def store_dir
      #ENV['STORAGE_PATH']
      "uploads" + "/thumbs/#{model.album.path}/#{model.id}"
    end
  end
  version :thumb_square, :from_version => :single do
    process :resize_to_fill => [240, 240]
    def store_dir
      #ENV['STORAGE_PATH']
      "uploads" + "/thumbs/#{model.album.path}/#{model.id}"
    end
  end
  
  def auto_orient
    manipulate! do |image|
      #image.tap(&:auto_orient)
      image.auto_orient
      image
    end
  end
  
  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
