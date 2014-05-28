# Homepage (Root path)
get '/' do
  erb :index
end

get '/users/new' do
  erb :'users/new'
end

post '/users/new' do
  @current_user = User.new(
  username: params[:username],
  password: params[:password]
  )
  if @current_user.save
  # binding.pry
    session[:user_id] = @current_user.id
    redirect "/photos"
  else
    erb :'users/new'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @current_user = User.where(username: params[:username], password: params[:password]).first

  @current_user = User.where("username = ? AND password = ? ", params[:username], params[:password]).first
  
  @current_user = User.find_by(username: params[:username], password: params[:password])

  if @current_user
    session[:user_id] = @current_user.id
    redirect '/photos'
  else
    erb :'users/login'
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/photos' do
  @current_user = User.find session[:user_id]
  # @photos = Photo.all
  erb :'photos/index'
end

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def is_logged_in?
  !current_user.nil? 
end

def authenticate
  redirect '/users/login' unless is_logged_in?
end

