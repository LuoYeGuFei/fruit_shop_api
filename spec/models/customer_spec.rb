require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:addresses).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:wechat) }
end
