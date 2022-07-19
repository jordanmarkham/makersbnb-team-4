require 'pg'

class User

  def self.login(session)
  end

  def self.logout(session)
  end

  def self.signup(username, firstname, lastname, email, password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    connection.exec "INSERT INTO users (username, firstname, lastname, email, password) VALUES ('#{username}', '#{firstname}', '#{lastname}', '#{email}', '#{password}');"
  end


end