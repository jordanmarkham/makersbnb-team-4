require 'pg'

class Profile

    def self.profile(username)
        if ENV['ENVIRONMENT'] == 'test'
            connection = PG.connect(dbname: 'makersbnb_test')
        else
            connection = PG.connect(dbname: 'makersbnb')
        end
        result = connection.exec "SELECT * FROM spaces WHERE username='#{username["username"]}';"
        puts username["username"]
        return result.map{ |row| "Name: #{row["name"]} | Description: #{row["description"]} | £/Night: #{row["price_per_night"]} | Username: #{row["username"]}"}.reverse
    end
end