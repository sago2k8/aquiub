class ImageUploader < CarrierWave::Uploader::Base

  def store_dir
    "public/images/uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
