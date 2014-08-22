CarrierWave.configure do |config|
  
  config.will_include_content_type = true
  config.default_content_type = 'image/jpg'
  config.validate_download = false
  
  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  elsif Rails.env.production? || Rails.env.development?
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_ACCESS_KEY'],                        # required
      :aws_secret_access_key  => ENV['S3_SECRET_ACCESS_KEY'],                        # required
      :region                 => ENV['S3_REGION'], # 'eu-west-1',                  # optional, defaults to 'us-east-1'
  #    :host                   => 's3.example.com',             # optional, defaults to nil
  #    :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    
    config.fog_directory  = ENV['S3_BUCKET_NAME']                     # required
    config.fog_public     = true                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    
    #config.storage = :fog
  else
    config.storage = :file
  end
 
  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
  
  
end