require 'rails_helper'

RSpec.describe Group, type: :model do

  fixtures :groups, :memberships, :users

  describe "assigning a different user" do
    before do
      @group = groups(:pepe_lola)

      @old_user_email = @group.emails.first
      @new_user_email = Faker::Internet.email

      @group.emails = [ @new_user_email ]
    end

    it "does not include old user email" do
      expect(@group.emails).not_to include(@old_user_email)
    end

    it "does include new user email" do
      expect(@group.emails).to include(@new_user_email)
    end
  end
end
