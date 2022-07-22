# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space'
require_relative 'lib/user'

class MakersBnb < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @formtype = params['form']
    @formtype = 'signup' if @formtype == nil
    @login = params['login']
    session[:status] == true ? redirect('/spaces') : erb(:index)
  end

  get '/signup' do
    redirect('/?form=signup')
  end

  post '/signup' do
    User.signup(params[:username], params[:firstname], params[:lastname], params[:email], params[:password])
    login(params[:email], params[:password])
    redirect('/spaces?signup=success')
  end

  get '/login' do
    redirect('/?form=login')
  end

  post '/login' do
    if login(params[:email], params[:password]) == true
      redirect('/spaces')
    else
      redirect('/?form=login&login=error')
    end
  end

  post '/logout' do
    logout
    redirect('/spaces')
  end

  get '/spaces' do
    @signup = params['signup']
    @booking = params['booking']
    @page = params['page']
    @all_spaces = Space.all
    erb(:spaces)
  end

  get '/spaces/new' do
    session[:status] == true ? erb(:new) : redirect('/')
  end

  post '/spaces/new' do
    session[:status] == true ? erb(:new) : redirect('/')
  end

  post '/create' do
    Space.create(params[:name], params[:description], params[:price_per_night], session[:username])
    redirect('/spaces')
  end

  get '/profile' do
    if session[:status] == true
      @your_spaces = User.view_spaces(session[:username])
      erb(:profile)
    else
      redirect('/')
    end
  end

  get '/spaces/view' do
    params[:id]
    @current_space = Space.find(params[:id].gsub('-', ' '))
    erb(:space)
  end

  post '/spaces/view' do
    redirect("/spaces/view?id=#{params[:name].gsub(' ', '-')}")
  end

  get '/book' do
    redirect("/spaces?page=notfound")
  end

  post '/book' do
    if session[:status] == true
      Space.book(params[:name], session[:username])
      redirect("/spaces?booking=success")
    else
      redirect('/')
    end
  end

  def login(email, password)
    connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec "SELECT username, email, passkey FROM users WHERE email='#{email}';"

    if password == result[0]['passkey']
      session[:username] = result[0]['username']
      session[:email] = result[0]['email']
      session[:password] = result[0]['passkey']
      session[:status] = true
      return true
    else
      return false
    end
  end

  def logout
    session[:username] = nil
    session[:email] = nil
    session[:password] = nil
    session[:status] = false
  end

  run! if app_file == $PROGRAM_NAME
end
