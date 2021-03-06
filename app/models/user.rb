class User < ActiveRecord::Base
  has_many :photos 
  
  def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        if auth.credentials && auth.credentials.expires_at
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        else
          user.oauth_expires_at = Time.now + 1.day
        end
        user.save!
      end
    end
end
