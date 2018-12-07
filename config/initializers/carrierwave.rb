if Rails.env == 'production'
CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AWS_ACCESS_KEY_ID',
    aws_secret_access_key: 'AWS_SECRET_ACCESS_KEY',
    region: 'ap-northeast-1'
  }
  
        
  config.fog_directory  = 'tsukuttapic'
  config.cache_storage = :fog
  end
end

