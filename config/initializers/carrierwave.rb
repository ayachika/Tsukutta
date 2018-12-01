if Rails.env == 'production'
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
config.fog_credentials = {
 provider: 'AWS',
 aws_access_key_id: ENV['AKIAIG5DUU4ZPQQQWNHQ'],
 aws_secret_access_key: ENV['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'],
 region: 'ap-northeast-1'
 }
config.fog_directory = ENV['tsukutta']
 config.asset_host = 'https://s3.ap-northeast-1.amazonaws.com/tsukutta'
end
end