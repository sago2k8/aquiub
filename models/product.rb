class Product

  include Mongoid::Document

  field :name,                          type: String
  field :description,                   type: String
  mount_uploader :product_picture,      ImageUploader

end
