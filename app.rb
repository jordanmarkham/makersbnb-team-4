# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space'
require_relative 'lib/profile'

class MakersBnb < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  post '/profile' do
    erb(:profile)
  end

  post '/profileview' do
     @profile = Profile.profile(params{:username})
    erb(:listing)
  end

  get '/login' do
    erb(:login)
  end

  get '/' do
    @all_spaces = Space.all
    erb(:index)
  end

  get '/new' do
    erb(:new)
  end

  post '/new' do
    erb(:new)
  end

  post '/' do
    Space.create(params[:name], params[:description], params[:price_per_night], params[:username] )
    redirect('/')
  end

  run! if app_file == $PROGRAM_NAME
end
