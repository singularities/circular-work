require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  describe "GET /organizations" do
    let(:method) { :get }
    let(:path) { organizations_path }
    let(:data) { {} }

    it_behaves_like 'is a valid request'
  end
end
