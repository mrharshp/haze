class UsersController < ApplicationController
  def index
    @users = policy_scope(User)
  end

  def show
    @user = current_user
    authorize @user
  end

  def edit
    @user = current_user
    authorize @user
  end

  def update
    @user = current_user
    authorize @user
    @user.update(user_params)
    redirect_to my_profile_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :photo, :homecurrency)
  end
end
