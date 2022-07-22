require 'pg'

class Space
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec "SELECT * FROM spaces"
    list = result.map do |row|
      case row["is_booked"]
      when "f"
        "<form action='/spaces/view' method='post'><button class='button' id='available' name='name' value='#{row["name"]}' type='submit'>#{row["name"]}   |   £/Night: #{row["price_per_night"]}   |   Posted by: #{row["username"]}<br>(Available!)</button></form>"
      when "t"
        "<form action='/spaces/view' method='post'><button class='button' id='unavailable' name='name' value='#{row["name"]}' type='submit'>#{row["name"]}   |   £/Night: #{row["price_per_night"]}   |   Posted by: #{row["username"]}<br>(Not Available)</button></form>"
      end
    end
    return list.reverse
  end

  def self.create(name, description, price_per_night, username = nil)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
      connection.exec "INSERT INTO spaces (name, description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}');"
    else
      connection = PG.connect(dbname: 'makersbnb')
      connection.exec "INSERT INTO spaces (name, description, price_per_night, username, is_booked) VALUES ('#{name}', '#{description}', '#{price_per_night}', '#{username}', false);"
    end
  end

  def self.book(name, username)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    connection.exec "UPDATE spaces SET is_booked = true, booked_by='#{username}' WHERE name='#{name}';"
  end

  def self.find(name)
    if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'makersbnb_test')
    else
        connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec "SELECT * FROM spaces WHERE name='#{name}';"
    return result.map do |row|
      case row["is_booked"]
      when "f"
        "<h1>#{row["name"]} </h1><h3>By #{row["username"]}</h2><br><p>#{row["description"]}</p><br><br><h3>£/Night: #{row["price_per_night"]}</h3><br><br><form action='/book' method='post'><button name='name' value='#{row["name"]}' class='button' type='submit'>Book!</button></form>"
      when "t"
        "<h4>Sorry, this Space is no longer available. Please try again at a later time.</h4><h1>#{row["name"]} </h1><br><h3>By #{row["username"]}</h2><br><p>#{row["description"]}</p><br><br><h3>£/Night: #{row["price_per_night"]}</h3><br><br>"
      end
    end
  end
end
