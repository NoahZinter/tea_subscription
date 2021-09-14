class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  validates :price, presence: true

  enum status: { 'pending': 0, 'cancelled': 1, 'active': 2 }
  enum frequency: { 'weekly': 0, 'monthly': 1, 'bi-monthly': 2 }
end
