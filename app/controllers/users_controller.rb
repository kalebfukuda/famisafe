class UsersController < ApplicationController
  before_action :authenticate_user!

  def update_location
    if current_user.update(latitude: params[:latitude], longitude: params[:longitude])
      render json: { status: "success" }
    else
      render json: { status: "error", errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
