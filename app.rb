# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/test' do
    'Test page'
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
    Space.create(params[:name], params[:description], params[:price_per_night])
    redirect('/')
  end

  run! if app_file == $PROGRAM_NAME
end
