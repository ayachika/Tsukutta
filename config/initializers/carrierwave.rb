CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
config.fog_credentials = {
 provider: 'AWS',
 aws_access_key_id: ENV['ACCESS_KEY_ID'],
 aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
 region: ENV['S3_REGION']
 }
 config.fog_directory = ENV['S3_BUCKET']
 config.asset_host = 'https://s3.ap-northeast-1.amazonaws.com/tsukutta'
end
