class CustomerSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :address, :email
  has_many :subscriptions
end
