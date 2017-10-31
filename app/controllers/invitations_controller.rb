class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_or_initialize_by(email: params[:email])

    if @user.new_record?
      @user.inviter = current_user
    end

    if ! @user.new_record? || @user.save

      UserMailer.invite(@user, current_user).deliver_now

      render json: { email: @user.email }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
end
