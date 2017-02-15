class Product

  include Mongoid::Document

  field :name,                          type: String
  field :description,                   type: String
  mount_uploader :profile_image,        ImageUploader

  def get_picture_url
    self.profile_image_url.blank? ? 'https://s3-us-west-2.amazonaws.com/laboratoday/public/images/default_profile_picture.png' : self.profile_image_url
  end

end
