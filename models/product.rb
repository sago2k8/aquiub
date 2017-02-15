class Product

  include Mongoid::Document

  field :name,                          type: String
  field :description,                   type: String
  mount_uploader :product_picture,      ImageUploader

  def get_picture_url
    self.product_picture_url.blank? ? 'https://s3-us-west-2.amazonaws.com/laboratoday/public/images/default_profile_picture.png' : self.product_picture_url
  end

end
