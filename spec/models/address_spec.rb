require 'rails_helper'

RSpec.describe Address, type: :model do

  it { should belong_to(:customer) }
  it { should validate_presence_of(:receiver) }
  it { should validate_presence_of(:tel) }
  it { should validate_presence_of(:addr) }
end
