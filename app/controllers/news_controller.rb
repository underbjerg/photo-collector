class NewsController < ApplicationController
  before_filter :check_public_access
  
  def latest
    @photos = Photo.all.where(:image_processed => true).order("created_at DESC").limit(100)
    
    @feed = segment(@photos)
  end
  
  def segment(photos)
    segments = [{ :photos => photos }]
    segments = segment_by(segments, :date){|photo| photo.created_at.to_date}
    segments = segment_by(segments, :user){|photo| photo.user}
    segments = segment_by(segments, :album){|photo| photo.album}
  end
  
  def segment_by(input_segments, attribute, &key_function)
    result_segments = []
    
    input_segments.each do |segment|
      current_key = nil
      new_segment = nil
      
      segment[:photos].each do |photo|
        if key_function.call(photo) != current_key
          current_key = key_function.call(photo)
          new_segment = { :user => segment[:user], :album => segment[:album], :date => segment[:date] } # preserve other attributes
          new_segment[attribute] = current_key
          new_segment[:photos] = []
          result_segments << new_segment
        end
        new_segment[:photos] << photo
      end
    end
    
    return result_segments
  end
  

end
