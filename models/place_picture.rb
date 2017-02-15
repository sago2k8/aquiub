class PlacePicture

  include Mongoid::Document

  mount_uploader :avatar, AvatarUploader

  belongs_to :place

end
