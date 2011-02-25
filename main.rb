require 'sinatra'
require 'mongo'

configure do
  set :path_root, '/'
  set :path_posts_new, '/posts/new'
  set :path_posts_create, '/posts/create'
  
  set :db, Mongo::Connection.new("localhost").db("coffeydev")
  set :posts, settings.db["posts"]
end

get settings.path_root do
  @posts = settings.posts.find.limit(10).sort(:created_at, :descending).map {|m| m}
  erb :index
end

get settings.path_posts_new do
  erb :edit, :locals => { :post => {}, :url => settings.path_posts_create }
end

post settings.path_posts_create do
  post = {
    "title" => params[:title],
    "body" => params[:body],
    "created_at" => Time.now
  }
  settings.posts.insert(post)
  redirect settings.path_root
end