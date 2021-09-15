class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency

  belongs_to :customer
  has_many :subscription_teas
end
