require 'sinatra'
require 'sequel'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')

configure do
  set :path_root, '/'
  set :path_posts_new, '/posts/new'
  set :path_posts_create, '/posts/create'
  
  set :database, Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://coffey.db')    
end

require 'post'

get settings.path_root do
  @posts = Post.reverse_order(:created_at)
  erb :index
end

get settings.path_posts_new do
  erb :edit, :locals => { :post => Post.new, :url => settings.path_posts_create }
end

post settings.path_posts_create do
  post = Post.new(
    :title => params[:title],
    :body => params[:body],
    :created_at => DateTime.now
  )
  post.save
  redirect settings.path_root
end