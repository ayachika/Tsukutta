
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

unless Rails.env.test?
CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  }
  
  config.fog_directory  = ENV['S3_BUCKET']
  config.cache_storage = :fog    
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/tsukuttapic'
  end
else
    CarrierWave.configure do |config|
    config.storage = :file
    end
  end

