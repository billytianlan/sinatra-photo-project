# Homepage (Root path)
get '/' do
  erb :index
end

get '/new' do
  erb :'users/new'
end

post '/new' do
  @current_user = User.new(
  username: params[:username],
  password: params[:password]
  )
# binding.pry
  if @current_user.save
    session[:user_id] = @current_user.id
    redirect "/photos"
  else
    erb :'users/signup'
  end
end

get '/login' do
  erb :'users/login'
end
