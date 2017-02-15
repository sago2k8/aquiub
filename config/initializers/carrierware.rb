CarrierWave.configure do |config|

  config.storage = :file
  config.cache_dir = "#{Padrino.root}/tmp/uploads"

end
