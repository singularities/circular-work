def with_valid_user_and_token(&block)
  fixtures :users

  context "with valid user and token" do
    let(:authorization_header) do
      pepe = users(:pepe)
      "Token token=\"#{ pepe.authentication_token }\", email=\"#{ pepe.email }\""
    end
    let(:headers) do
      { "HTTP_AUTHORIZATION" =>  authorization_header }
    end

    self.instance_exec(&block)
  end
end

def login_user
  @request.env["devise.mapping"] = Devise.mappings[:user]
  sign_in users(:pepe)
end
