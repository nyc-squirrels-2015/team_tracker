put '/teams/:id/add_players' do |id|
  p params[:players]

  return_obj = []

  params[:players].each_value do |player_id|
    tp_instance = TeamPlayer.create(player_id: player_id, team_id: id)
    my_jam = {name: "#{TeamPlayer.find(tp_instance.id).player.last_name}, #{TeamPlayer.find(tp_instance.id).player.first_name}",
              pos: "#{TeamPlayer.find(tp_instance.id).player.position}",
              pro_team: "#{TeamPlayer.find(tp_instance.id).player.pro_team}",
              age: TeamPlayer.find(tp_instance.id).player.age}
    return_obj.push(my_jam)
  end

  p return_obj.to_json

  return return_obj.to_json

end

delete '/teams/:id/delete_player' do |id|
  TeamPlayer.find_by(team_id: id, player_id: params[:player_id]).destroy
end
