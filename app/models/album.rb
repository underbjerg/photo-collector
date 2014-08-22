class Album < ActiveRecord::Base
  has_many :photos, :dependent => :delete_all
  
  validates :path, presence: true, uniqueness: true#, :message => "Path must be unique across all albums"
  
  before_validation :ensure_path
  
  
  def ensure_path
    self.path = self.title.parameterize unless self.path
  end
  
end
