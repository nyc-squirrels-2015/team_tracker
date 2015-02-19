get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user.try(:authenticate, params[:password])
    session[:id] = user.id
    if request.xhr?
      {status: 200, path: "/"}.to_json
    else
      redirect '/'
    end
  else
    if request.xhr?
      401
    else
      redirect '/login'
    end
  end
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
