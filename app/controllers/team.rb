get '/' do
  @teams = Team.all.order(score: :desc)
  erb :main
end

get '/teams/new' do
  @players = Player.all.order(last_name: :asc)
  erb :team_new
end

get '/teams/:id' do |id|
  @team = Team.find(id)
  erb :team_show
end

post '/teams' do
  if session[:id] == nil
    redirect '/login'
  else
    user = User.find(session[:id])
    new_team = Team.create(name: params[:team_name], user_id: user.id )
    TeamPlayer.create(player_id: params[:player], team_id: new_team.id)
    redirect '/'
  end
end

get '/teams/:id/edit' do |id|
  @team = Team.find(id)
  erb :team_edit
end

put '/teams/:id' do |id|
  Team.find(id).update_attributes(name: params[:team_name])
  redirect "/teams/#{id}"
end

get '/teams/:id/delete' do |id|
  @team = Team.find(id)
  erb :team_delete
end

delete '/teams/:id' do |id|
  Team.find(id).destroy
  redirect "/users/#{session[:id]}"
end

put '/teams/:id/vote' do |id|
  team = Team.find(id)
  if session[:id] == nil
    # Anyone who is not logged in cannot vote
    redirect '/login'
  elsif team.user.id == session[:id]
    # This prevents users from voting for their own teams
    redirect '/'
  else
    team.score += 1
    team.save
    redirect '/'
  end
end
