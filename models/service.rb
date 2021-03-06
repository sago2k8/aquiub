class Service

  include Mongoid::Document

  field :name,                          type: String
  field :description,                          type: String
  # Types: 1 (Pestañas), 2 (Cejas), default (Pestañas)
  field :type,                          type: Integer, default: 1
  mount_uploader :service_picture,      ImageUploader

  # belongs_to :place

end
