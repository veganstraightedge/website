if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.storage =  :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV["DXE_AWS_ACCESS_KEY"],
      aws_secret_access_key: ENV["DXE_AWS_SECRET_KEY"],
      region:                'us-west-1'  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = "dxe-development"
    # config.asset_host       = 'http://assets.dateedge.com'
    # config.fog_public     = false
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
end

