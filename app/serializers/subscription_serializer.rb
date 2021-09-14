class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency

  belongs_to :customer
end
