# Homepage (Root path)
# helpers do
#   # Usable in ERB templates everywhere, and in any action below
#   def current_user
#     @current_user ||= User.find(session[:user_id]) if session[:user_id]
#   end
# end

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
    @theme = Theme.where("DATE(created_at) = ?", Date.today).first
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
  @photos = Photo.all
  @theme = Theme.where("DATE(created_at) = ?", Date.today).first
  erb :'photos/index'
end

post '/photos' do
  @current_user = User.find session[:user_id]
    @photos = Photo.all
  erb :'photos/show' 
end



get '/photos/new' do
  @current_user = User.find(session[:user_id])
  @theme = Theme.where("DATE(created_at) = ?", Date.today).first
  erb :'photos/new'
end


post '/photos/new' do
  @current_user = User.find session[:user_id]
  # @photos = Photo.all
  @theme = Theme.where("DATE(created_at) = ?", Date.today).first
  @photo = Photo.new(
  url: params[:url],
  description: params[:description],
  user_id:  @current_user.id,
  theme_id: @theme.id
  )
  if @photo.save
    @theme = Theme.where("DATE(created_at) = ?", Date.today).first
    redirect '/user'
# binding.pry 
  else
  erb :'photos/show'
  end
end

get '/photos/show' do
  @current_user = User.find session[:user_id]
  erb :'photos/new'
end

get '/user/:id' do
  @current_user = User.find session[:user_id]
  @view_user = User.find params[:id]
  @photos = @view_user.photos
    @theme = Theme.where("DATE(created_at) = ?", Date.today).first
  erb :'user/show'
end

get '/photos/:id' do
  @photo = Photo.find params[:id]
  @current_user = User.find session[:user_id]
  erb :'photos/show'
end

post '/vote/:id' do
  # binding.pry
  @vote = Vote.new(
    photo_id: params[:id],
    user_id: session[:user_id]
    )
  @vote.save
  redirect "/photos/#{params[:id]}"
end

get '/hot' do
  @current_user = User.find(session[:user_id])
  @theme = Theme.where("DATE(created_at) = ?", Date.today).first
  @photos = Photo.all
  @photos.sort! { |x,y| y.votes.size <=> x.votes.size }
  erb :'photos/hot'
end



# def current_theme
#   @theme = Theme.where("DATE(created_at) = ?", Date.today).first
# end













def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def is_logged_in?
  !current_user.nil? 
end

def authenticate
  redirect '/users/login' unless is_logged_in?
end

