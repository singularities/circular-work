require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  describe "GET /organizations" do
    let(:method) { :get }
    let(:path) { organizations_path }
    let(:data) { {} }

    with_valid_user_and_token do
      it_behaves_like 'is a valid request'
    end
  end
end
