require 'pg'
require 'space'

feature 'Viewing spaces page' do
  scenario 'Buttons and headers show onscreen' do
    visit('/spaces')
    expect(page).to have_content 'MakersBnb:'
    expect(page).to have_content 'Create Listing'
    expect(page).to have_content 'All Spaces:'
  end
end

feature 'Viewing Spaces' do
  scenario 'A user can see all Spaces' do
    connection = PG.connect(dbname: 'makersbnb_test')

    # Add the test data
    Space.create('Test Space 2', 'Test Desc 2', '100')

    visit('/spaces')

    expect(page).to have_content 'Name: Test Space 2 | Description: Test Desc 2 | £/Night: 100 | Posted by:'
  end
end
