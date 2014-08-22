class Photo < ActiveRecord::Base
  belongs_to :album
  
  mount_uploader :image_file, FileUploader

    def save_and_process_image_file(options = {})
      if options[:now]
        #puts "Photo valid?: " + valid?.to_s + "(" + errors.full_messages.join(" ") + ")"
        #puts "Photo: " + self.inspect
        #puts "ImageFile (uploader): " + image_file.inspect
        puts "save_and_process_image_file found fog_url: " + image_file.direct_fog_url(:with_path => true)
        self.remote_image_file_url = image_file.direct_fog_url(:with_path => true)
        puts "remote_image_file_url set, saving..."
        save!
        self.update_column(:image_processed, true)
      else
        Resque.enqueue(ImageFileProcessor, id, key, attributes)
      end
    end

  private
  
end

class ImageFileProcessor
  @queue = :image_file_processor_queue

  def self.perform(id, key, attributes)
    puts "Photo.perform(attributes) called. Attempting to create new photo with attributes: " + attributes.to_s
    photo = Photo.find(id)
    photo.key = key
    photo.album_id = attributes["album_id"]
    photo.save_and_process_image_file(:now => true)
  end
end
