if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              =>  'AWS',
      :region                =>  ENV['S3_REGION'], # eu-west-1, defaults to 'us-east-1'
      :aws_access_key_id     =>  ENV['S3_ACCESS_KEY'], # AKIAJLIQ5LEKAAF3CR2Q
      :aws_secret_access_key =>  ENV['S3_SECRET_KEY'] # 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
    }
    config.fog_directory     =  ENV['S3_BUCKET'] # insurance-pricing-room
  end
end
