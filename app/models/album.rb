class Album < ActiveRecord::Base
  has_many :photos, -> { order 'capture_time ASC' }, :dependent => :delete_all
  has_many :photos_unordered, :class_name => 'Photo'
  has_many :users, -> { uniq }, through: :photos_unordered
  
  validates :path, presence: true, uniqueness: true#, :message => "Path must be unique across all albums"
  
  before_validation :ensure_path
  
  
  def ensure_path
    self.path = self.title.parameterize unless self.path
  end
  
  def cover_photo
    photos_unordered.order("use_as_cover DESC, capture_time ASC").first
  end
  
end
