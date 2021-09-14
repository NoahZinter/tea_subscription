class Subscription < ApplicationRecord
  belongs_to :customer

  enum status: { 'pending': 0, 'cancelled': 1, 'active': 2 }
  enum frequency: { 'weekly': 0, 'monthly': 1, 'bi-monthly': 2 }
end
