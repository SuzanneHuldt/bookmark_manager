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
    erb(:link)
  end

  get '/links/new' do
    erb(:newlinks)

  end

  get '/tag/:tag' do
    @tag = params[:tag]
    tag = Tag.first(tag: @tag)
    @links = tag ? tag.links : []
    erb(:link)
  end

  post '/links' do
   link = Link.first_or_create(url: params[:url], title: params[:title])
   tags = params[:tag].split(', ')
   tags.each do |tag_name|
     p tag_name
     tag = Tag.first_or_create(tag: tag_name)
     LinkTag.create(:link => link, :tag => tag)
   end
   redirect to('/links')
 end

  run! if app_file == $0
end
