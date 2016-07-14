CarrierWave.configure do |config|

	if Rails.env.production?
		config.fog_credentials = {
			# Configuration for Amazon S3
	    :provider              => 'AWS',
	    :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
	    :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  elsif Rails.env.test?
  	config.storage = :file
  	config.enable_processing = false
  elsif Rails.env.development?
  	config.storage = :file
	end
end


