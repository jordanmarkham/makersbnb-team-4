require 'pg'

class User

  # def self.login(username, email, password)
  #   session[:username] = username
  #   session[:email] = email
  #   session[:password] = password
  #   session[:logged_in?] = true
  # end

  # def self.logout
  #   session[:username] = nil
  #   session[:email] = nil
  #   session[:password] = nil
  #   session[:logged_in?] = false
  # end

  def self.signup(username, firstname, lastname, email, password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    connection.exec "INSERT INTO users (username, firstname, lastname, email, passkey) VALUES ('#{username}', '#{firstname}', '#{lastname}', '#{email}', '#{password}');"
  end

end