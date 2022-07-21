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

  get '/test' do
    'Test page'
  end

  get '/' do
    session[:logged_in?] == true ? redirect('/spaces') : erb(:index)
  end

  get '/signup' do
    redirect('/')
  end

  post '/signup' do
    User.signup(params[:username], params[:firstname], params[:lastname], params[:email], params[:password])
    login(params[:username], params[:email], params[:password])
    redirect('/spaces?signup=success')
  end

  post '/login' do
    session[:logged_in?] = true
  end

  post '/logout' do
    logout
    redirect('/spaces')
  end

  get '/spaces' do
    @success = params['signup']
    @all_spaces = Space.all
    erb(:spaces)
  end

  get '/spaces/new' do
    session[:logged_in?] == true ? erb(:new) : redirect('/')
  end

  post '/spaces/new' do
    session[:logged_in?] == true ? erb(:new) : redirect('/')
  end

  post '/create' do
    Space.create(params[:name], params[:description], params[:price_per_night], session[:username])
    redirect('/spaces')
  end

  def login(username, email, password)
    session[:username] = username
    session[:email] = email
    session[:password] = password
    session[:logged_in?] = true
  end

  def logout
    session[:username] = nil
    session[:email] = nil
    session[:password] = nil
    session[:logged_in?] = false
  end


  run! if app_file == $PROGRAM_NAME

end
