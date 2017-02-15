class Place

  include Mongoid::Document

  field :name,                          type: String
  field :address,                       type: String
  field :latitude,                      type: String
  field :longitude,                     type: String

  mount_uploader :header_picture,       ImageUploader
  mount_uploader :pestanas_picture,     ImageUploader
  mount_uploader :cejas_picture,        ImageUploader

  has_many :services
  has_many :place_pictures

  accepts_nested_attributes_for :place_pictures

  def get_header_picture_url
    self.header_picture_url.blank? ? '../img/foto-cabecera-completa.png' : self.header_picture_url
  end

  def get_pestanas_picture_url
    self.pestanas_picture_url.blank? ? 'https://s3-us-west-2.amazonaws.com/laboratoday/public/images/default_profile_picture.png' : self.pestanas_picture_url
  end

  def get_cejas_picture_url
    self.cejas_picture_url.blank? ? 'https://s3-us-west-2.amazonaws.com/laboratoday/public/images/default_profile_picture.png' : self.cejas_picture_url
  end

  def get_place_pitures
    urls = []
    self.place_pictures.each do |p|
      urls << p.get_picture_url
    end
    urls
  end
end
