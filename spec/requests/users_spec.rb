require 'rails_helper'

describe 'Users requests', type: :request do
  describe 'most active users list' do
    before do
      create_list(:user, 12, :with_comments)
    end

    it 'displays 10 most active users from last 7 days' do
      visit('/users/most_active')
      expect(page).to have_selector('table tbody tr', count: 10)
    end
  end
end