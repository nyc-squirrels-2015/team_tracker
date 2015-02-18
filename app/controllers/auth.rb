get '/' do
  @teams = Team.all
  erb :main
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user.try(:authenticate, params[:password])
    session[:id] = user.id
    redirect "/"
    # {status: 200, path: "/"}
  else
    redirect '/login'
    #401
  end
  #Change to above comments here when implementing AJAX
end

post '/signup' do

  user = User.new(params[:new_user])
  user.save

  if user.save
    session[:id] = user.id
    redirect "/"
  else
    # Try throwing an error here as well
    redirect '/login'
  end
end

get '/logout' do
  # Check this because redirecting in a get route
  session.clear
  redirect '/'
end
