require "rails_helper"
include Warden::Test::Helpers

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

    context 'when user is logged in' do
      let(:user) { create(:user) }

      before { login_as(user, :scope => :user) }

      after { Warden.test_reset! }

      it 'displays new comment form' do
        visit "/movies/#{movie.id}"
        expect(page).to have_selector('form.new_comment')
      end

      context 'when user did not comment this movie already' do
        it 'allows user to add new comment' do
          visit "/movies/#{movie.id}"
          fill_in 'comment_text', with: Faker::Lorem.sentence
          click_button 'Create'
          expect(page).to have_selector('div.well', count: 4)
        end

        it 'not allows user to add new comment without content' do
          visit "/movies/#{movie.id}"
          click_button 'Create'
          expect(page).to have_selector('div.well', count: 3)
        end
      end

      context 'when user commented this movie' do
        before { create(:comment, user: user, movie: movie) }

        it 'does not allow user to add new comment' do
          visit "/movies/#{movie.id}"
          fill_in 'comment_text', with: Faker::Lorem.sentence
          click_button 'Create'
          expect(page).to have_selector('div.well', count: 4)
        end
      end

      it 'allows user to delete his comment' do
        create(:comment, user: user, movie: movie)
        visit "/movies/#{movie.id}"
        expect(page).to have_selector('div.well', count: 4)
        click_link 'Delete'
        expect(page).to have_selector('div.well', count: 3)
      end

      it 'does not allow user to delete not his comments' do
        visit "/movies/#{movie.id}"
        expect(page).to_not have_selector("a[href='#{movie_comments_path(movie)}'][data-method='delete']", count: 3)
      end
    end

    context 'when user is not logged in' do
      it 'does not displays new comment form' do
        visit "/movies/#{movie.id}"
        expect(page).not_to have_selector('form.new_comment')
      end
    end
  end
end
