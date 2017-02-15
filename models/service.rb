class Service

  include Mongoid::Document

  field :name,                          type: String
  # Types: 1 (Pestañas), 2 (Cejas), default (Pestañas)
  field :type,                          type: Integer, default: 1

  belongs_to :place

end
