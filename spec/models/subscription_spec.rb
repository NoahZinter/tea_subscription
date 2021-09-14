require 'rails_helper'

RSpec.describe Subscription do
  describe 'relationships' do
    it { should belong_to(:customer) }
  end

  describe 'validations' do
    it { should validate_presence_of(:price)}
  end

  describe 'enums' do
    it { should define_enum_for(:status).with(['pending', 'cancelled', 'active'])}
    it { should define_enum_for(:frequency).with(['weekly', 'monthly', 'bi-monthly'])}
  end
end
