class PlacePicture

  include Mongoid::Document

  mount_uploader :picture,              ImageUploader

  belongs_to :place

end
