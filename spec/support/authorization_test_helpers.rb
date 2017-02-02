def with_valid_user_and_token(&block)
  fixtures :users

  context "with valid user and token" do
    let(:headers) { users(:pepe).create_new_auth_token }

    self.instance_exec(&block)
  end
end

def login_user(user = users(:pepe))
  user_headers = user.create_new_auth_token
  @request.headers.merge!(user_headers)
end
