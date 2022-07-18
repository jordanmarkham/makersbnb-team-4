require 'pg'

class Space
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec "SELECT * FROM spaces"
    return result.map{ |elem| "Name: #{elem["name"]} | Description: #{elem["description"]} | £/Night: #{elem["price_per_night"]}"}.reverse
  end

  def self.create(name, description, price_per_night)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    connection.exec "INSERT INTO spaces (name, description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}');"
  end
end
