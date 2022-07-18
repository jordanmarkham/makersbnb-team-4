# frozen_string_literal: true

require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec('TRUNCATE spaces;')
end

def add_row_to_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("INSERT INTO spaces (name, description, price_per_night) VALUES ('My Space', 'This is my Space!', '£150');")
end
