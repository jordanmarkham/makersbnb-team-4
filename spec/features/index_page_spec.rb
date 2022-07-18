# frozen_string_literal: true

feature 'Viewing home page' do
  scenario 'visiting the home page' do
    visit('/')
    expect(page).to have_content 'MakersBnb:'
    expect(page).to have_content 'Create Listing'
    expect(page).to have_content 'All Spaces:'
  end
end
