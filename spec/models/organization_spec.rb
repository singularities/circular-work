require 'rails_helper'

RSpec.describe Organization, type: :model do

  fixtures :users, :organizations, :admins, :groups

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

    it "generates token" do
      expect(@organization.token).not_to be nil
    end

  end

  describe "assigning a different admin" do
    before do
      @organization = organizations(:singularities)
      @organization.current_admin = @organization.admin_users.first

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
      @organization.current_admin = @organization.admin_users.first
    end

    it "raises an error" do
      expect { @organization.admin_emails = [] }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "#shows_to?" do
    before do
      @organization = organizations(:singularities)
      # after_create callback is not triggered for fixtures
      @organization.refresh_token
    end

    it "allows admin" do
      expect(@organization.shows_to?(user: users(:pepe))).to be true
    end

    it "allows user" do
      expect(@organization.shows_to?(user: users(:lola))).to be true
    end

    it "does not allow other user" do
      expect(@organization.shows_to?(user: users(:maria))).to be_falsy
    end

    it "allows right token" do
      expect(@organization.shows_to?(token: @organization.token)).to be true
    end

    it "does not allow wrong token" do
      expect(@organization.shows_to?(token: SecureRandom.hex)).to be_falsy
    end

    it "allows admin and wrong token" do
      expect(@organization.shows_to?(user: users(:pepe), token: SecureRandom.hex)).to be true
    end

    it "allows other user and right token" do
      expect(@organization.shows_to?(user: users(:maria), token: @organization.token)).to be true
    end

    it "does not allow other user and wrong token" do
      expect(@organization.shows_to?(user: users(:maria), token: SecureRandom.hex)).to be_falsy
    end
  end
end
