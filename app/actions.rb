# Homepage (Root path)
get '/' do
  erb :index
end

get '/new' do
  erb :'users/new'
end

get '/login' do
  erb :'users/login'
end
