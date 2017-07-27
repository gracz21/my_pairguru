require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe 'show movie' do
    let(:movie) { create :movie, :with_comments }

    it 'displays right movie comments' do
      visit "/movies/#{movie.id}"
      expect(page).to have_selector('h3', text: 'Comments')
      expect(page).to have_selector('div.well', count: 3)
    end
  end
end
