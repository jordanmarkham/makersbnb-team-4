# frozen_string_literal: true

require 'pg'
require 'space'

describe '.all' do
  it 'Returns all Spaces in reverse chronological order' do
    connection = PG.connect(dbname: 'makersbnb_test')

    # Add the test data
    Space.create('New Space 1!', 'Description 1', '100')
    Space.create('New Space 2!', 'Description 2', '200')
    Space.create('New Space 3!', 'Description 3', '300')

    spaces = Space.all

    expect(spaces).to include('Name: New Space 1! | Description: Description 1 | £/Night: 100 | Posted by: ')
    expect(spaces).to include('Name: New Space 2! | Description: Description 2 | £/Night: 200 | Posted by: ')
    expect(spaces).to include('Name: New Space 3! | Description: Description 3 | £/Night: 300 | Posted by: ')
  end
end

describe '.create' do
  it 'adds Spaces to the database' do
    connection = PG.connect(dbname: 'makersbnb_test')
    Space.create('New Space!', 'Description', '1000')
    spaces = Space.all
    expect(spaces).to include('Name: New Space! | Description: Description | £/Night: 1000 | Posted by: ')
  end
end
