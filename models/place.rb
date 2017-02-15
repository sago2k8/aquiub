class Place

  include Mongoid::Document

  field :name,                          type: String
  field :latitude,                      type: String
  field :longitude,                     type: String

  has_many :services
  has_many :place_pictures

  accepts_nested_attributes_for :place_pictures

end
