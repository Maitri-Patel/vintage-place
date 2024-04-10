# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    def update
        if @user.update(user_params)
          redirect_to profile_path, notice: 'Profile was successfully updated.'
        else
          render :edit
        end
      end
  
    private
  
    def user_params
        params.require(:user).permit(:name, :email, :address, :city, :province_id, :postal_code) # Change :province to :province_id
      end
  end
  