require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'users' do
    it { should belong_to(:user) }
    it { should validate_presence_of(:user) }
  end

  context 'movie' do
    it { should belong_to(:movie) }
    it { should validate_presence_of(:movie) }
  end

  context 'text' do
    it { should validate_presence_of(:text) }
  end
end
