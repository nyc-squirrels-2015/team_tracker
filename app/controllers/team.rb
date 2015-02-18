
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
