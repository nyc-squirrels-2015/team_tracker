require_relative '../spec_helper'

class AuthSpec
  describe 'auth' do
    let(:user) {User.create(username: "bob", email: "bob@gmail.com", password: "1234")}

  before do
    user
  end

  it 'should respond to /login' do
    get "/login"
    expect(last_response).to be_ok
    expect(last_response.body).to include 'Log In'
  end

  # it 'should respond to /login post' do
  #   post '/login', params = {username: "bob", password: "1234"}
  #   expect(last_response).to be_redirect
  #   follow_redirect!
  #   expect(last_response.body).to include 'Featured'
  # end

  it 'should respond to /signup post' do
    post '/signup', params={ new_user: {username: "steve", email: "steve@gmail.com", password: "1234"} }
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_response.body).to include 'Featured'
  end

  end
end
