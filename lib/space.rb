require 'pg'

class Space
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec "SELECT * FROM spaces"
    return result.map{ |row| "Name: #{row["name"]} | Description: #{row["description"]} | £/Night: #{row["price_per_night"]} | Posted by: #{row["username"]}"}.reverse
  end

  def self.create(name, description, price_per_night, username = nil)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
      connection.exec "INSERT INTO spaces (name, description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}');"
    else
      connection = PG.connect(dbname: 'makersbnb')
      connection.exec "INSERT INTO spaces (name, description, price_per_night, username) VALUES ('#{name}', '#{description}', '#{price_per_night}', '#{username}');"
    end
  end
end
