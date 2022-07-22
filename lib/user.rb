require 'pg'

class User
  def self.signup(username, firstname, lastname, email, password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    connection.exec "INSERT INTO users (username, firstname, lastname, email, passkey) VALUES ('#{username}', '#{firstname}', '#{lastname}', '#{email}', '#{password}');"
  end

  def self.view_spaces(username)
    if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'makersbnb_test')
    else
        connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec "SELECT * FROM spaces WHERE username='#{username}';"
    list = result.map do |row|
      case row["is_booked"]
      when "f"
        "Name: #{row["name"]}<br><br>Description: #{row["description"]}<br>£/Night: #{row["price_per_night"]}<br><br>Status: Not Booked"
      when "t"
        "Name: #{row["name"]}<br><br>Description: #{row["description"]}<br><br>£/Night: #{row["price_per_night"]}<br><br>Status: Booked<br><br>Booked By: #{row["booked_by"]}"
      end
    end
    return list.reverse
  end


end