class UsersController < ApplicationController

  def show
    @user = current_user
    authorize @user
  end

  # def edit
  #   @user = user
  # end

  # def update
  #   @user = user
  #   @user.update(user_params)
  #   # redirect_to my_profile_path(@user)
  # end

  private

  # def user_params
  #   params.require(:user).permit(:name, :email)
  # end
end
