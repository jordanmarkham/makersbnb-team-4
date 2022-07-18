# frozen_string_literal: true

require 'pg'
require 'space'

feature 'Viewing Spaces' do
  scenario 'A user can see all Spaces' do
    connection = PG.connect(dbname: 'makersbnb_test')

    # Add the test data
    Space.create('Test Space 2', 'Test Desc 2', '100')

    visit('/')

    expect(page).to have_content 'Name: Test Space 2 | Description: Test Desc 2 | £/Night: 100'
  end
end
