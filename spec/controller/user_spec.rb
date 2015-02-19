require_relative '../spec_helper'

class UserSpec
  describe 'users' do
    let(:user) {User.create(username: "bob", email: "bob@gmail.com", password_digest: "1234")}

  before do
    user
  end

  it 'should respond to /users/:id' do
    get "/users/#{user.id}"
    expect(last_response).to be_ok
    expect(last_response.body).to include 'bob'
  end

  it 'should respond to /users/:id/edit' do
    get "/users/#{user.id}/edit"
    expect(last_response).to be_ok
    expect(last_response.body).to include 'information'
  end

  it 'should respond to /users/:id/delete' do
    get "/users/#{user.id}/delete"
    expect(last_response).to be_ok
    expect(last_response.body).to include 'bob'
  end



  end
end
