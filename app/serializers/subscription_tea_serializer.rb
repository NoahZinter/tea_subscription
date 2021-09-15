class SubscriptionTeaSerializer
  include JSONAPI::Serializer
  attributes :subscription_id, :tea_id
end
