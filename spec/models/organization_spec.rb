require 'rails_helper'

RSpec.describe Organization, type: :model do

  fixtures :users, :organizations, :admins

  describe "after creating" do
    let(:organization_params) {
      {
        name: "Test organization",
        author: users(:pepe)
      }
    }

    before do
      @organization = Organization.create organization_params
    end

    it "includes author as admin" do
      expect(@organization.admin_users).to include(users(:pepe))
    end

    it "includes author email as admin_email" do
      expect(@organization.admin_emails).to include(users(:pepe).email)
    end

  end

  describe "assigning a different admin" do
    before do
      @organization = organizations(:singularities)

      @old_admin_email = @organization.admin_emails.first
      @new_admin_email = Faker::Internet.email

      @organization.admin_emails = [ @new_admin_email ]
    end

    it "does not include old admin email" do
      expect(@organization.admin_emails).not_to include(@old_admin_email)
    end

    it "does include new admin email" do
      expect(@organization.admin_emails).to include(@new_admin_email)
    end
  end

  describe "when removing all admins" do
    before do
      @organization = organizations(:singularities)
    end

    it "raises an error" do
      expect { @organization.admin_emails = [] }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
