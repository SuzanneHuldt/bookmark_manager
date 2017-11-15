ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/link.rb'
require_relative './models/tag.rb'
require 'dm-postgres-adapter'
require_relative './data_mapper_setup'

class App < Sinatra::Base

  enable :sessions

  get '/' do
    erb(:index)
  end

  get '/links' do
    @links = Link.all
    @link_tag = LinkTag.all
    erb(:link)
  end

  get '/links/new' do
    erb(:newlinks)

  end

  post '/links' do
   link = Link.create(url: params[:url], title: params[:title])
   tag = Tag.create(tag: params[:tag])
   LinkTag.create(:link => link, :tag => tag)
   redirect to('/links')
 end

  run! if app_file == $0
end
