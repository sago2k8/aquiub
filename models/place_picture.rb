class PlacePicture

  include Mongoid::Document

  mount_uploader :picture,              ImageUploader

  belongs_to :place

  def get_picture_url
    self.picture_url.blank? ? 'https://s3-us-west-2.amazonaws.com/laboratoday/public/images/default_profile_picture.png' : self.picture_url
  end

end
