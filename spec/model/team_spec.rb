require_relative '../spec_helper'

class TeamSpec
  describe 'team' do
    let(:user) {User.create(id: 1, username: "Kenn", email: "kenn@gmail.com", password: "1234")}
    let(:team) {Team.create(id: 1, name: "Girouxsalem", user_id: 1) }
    let(:player) {Player.create(id: 1, last_name: "Giroux", first_name: "Claude", pro_team: "Flyers", age: 27, position: "C")}
    let(:teamplayer) {TeamPlayer.create(team_id: 1, player_id: 1)}

  before do
    user
    team
    player
    teamplayer
  end

  it 'should respond to users' do
    expect(team.user.username).to eq("Kenn")
  end

  it 'should respond to players' do
    expect(team.players.find(player.id).last_name).to eq("Giroux")
  end

  end
end
