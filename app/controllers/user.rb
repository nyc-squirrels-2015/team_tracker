get '/users/:id' do |id|
  @user = User.find(id)
  erb :user_show
end

get '/users/:id/edit' do |id|
  @user = User.find(id)
  erb :user_edit
end

put '/users/:id' do |id|
  # params[:edit].delete_if do |key, value|
  #   value == ""
  # end
  strip_empty(param[:edit])
  User.find(id).update_attributes(params[:edit])
  redirect "/users/#{id}"
end

get '/users/:id/delete' do |id|
  @user = User.find(id)
  erb :user_delete
end

delete '/users/:id' do |id|
  User.find(id).destroy
  session.clear
  redirect '/'
end
