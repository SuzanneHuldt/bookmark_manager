ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/link.rb'
require 'dm-postgres-adapter'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!


class App < Sinatra::Base

  enable :sessions

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
