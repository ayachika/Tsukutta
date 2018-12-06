require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
 config.fog_credentials = {
 provider: 'AWS',
 aws_access_key_id: ENV['S3_ACCESS_KEY'],
 aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
 region: ENV['S3_REGION']
 }
 config.fog_directory = 'tsukutta'
end
end