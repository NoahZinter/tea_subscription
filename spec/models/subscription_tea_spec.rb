require 'rails_helper'

RSpec.describe SubscriptionTea do
  describe 'relationships' do
    it { should belong_to(:tea) }
    it { should belong_to(:subscription)}
  end
end
