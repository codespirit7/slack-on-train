class Url
  include Mongoid::Document
  include Mongoid::Timestamps
  field :shortId, type: String
  field :originalUrl, type: String
end
