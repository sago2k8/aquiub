class Special
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :body, :type => String
  field :expiration, :type => DateTime

  mount_uploader :picture,              ImageUploader

end
