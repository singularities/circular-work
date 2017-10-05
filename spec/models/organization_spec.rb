require 'rails_helper'

RSpec.describe Organization, type: :model do

  fixtures :users

  describe "after creating" do
    let(:organization_params) {
      {
        name: "Test organization",
        author: users(:pepe)
      }
    }

    it "includes author as admin" do

      org = Organization.create organization_params

      expect(org.admin_users).to include(users(:pepe))
    end

  end

end
