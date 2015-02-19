get '/' do
  @teams = Team.all.order(score: :desc)
  erb :main
end

get '/teams/new' do
  if session[:id] == nil
    redirect '/login'
  else
    @players = Player.all.order(last_name: :asc)
    erb :team_new
  end
end

get '/teams/new/add_player' do
  @num_players = params[:player_count].to_i
  @players = Player.all.order(last_name: :asc)
  erb :_add_player, layout: false
end

get '/teams/:id' do |id|
  @team = Team.find(id)
  erb :team_show
end

post '/teams' do
  user = User.find(session[:id])
  new_team = Team.create(name: params[:team_name], user_id: user.id )
  params[:players].each_value do |player_id|
    TeamPlayer.create(player_id: player_id, team_id: new_team.id)
  end
  redirect '/'
end

get '/teams/:id/edit' do |id|
  @team = Team.find(id)
  erb :team_edit
end

put '/teams/:id' do |id|
  if User.find_by(username: params[:edit_team][:username]) == nil
    params[:edit_team][:username].clear
  elsif params[:edit_team][:username] != nil
    params[:edit_team][:user_id] = User.find_by(username: params[:edit_team][:username]).id
    params[:edit_team][:username].clear
  end

  strip_empty(params[:edit_team])

  Team.find(id).update_attributes(params[:edit_team])
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
    if request.xhr?
      401
    else
      redirect '/login'
    end
  elsif team.user.id == session[:id]
    # Restriction that you cannot vote for your own team
    nil
  else
    team.score += 1
    team.save
    if request.xhr?
      {team_id: id, score: team.score}.to_json
    else
      redirect '/'
    end
  end
end
