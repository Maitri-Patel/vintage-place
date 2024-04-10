class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user # You need this to populate the form with the user's current information
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :edit # Render 'edit' instead of 'show' to show the form again with errors
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :address_line1, :city, :province_id, :postal_code) # Change :province to :province_id
  end
end
