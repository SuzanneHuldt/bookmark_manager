require 'sinatra/base'
require_relative './models/link.rb'

class App < Sinatra::Base

  enable :sessions

  set :session_secret, 'key'


  get '/' do
    erb(:index)
  end

  get '/links' do
    @links = Link.all
    erb(:link)
  end

  get '/links/new' do
    erb(:newlinks)

  end

  post '/links' do
   Link.create(url: params[:url], title: params[:title])
    redirect to('/links')
  end

  run! if app_file == $0
end
