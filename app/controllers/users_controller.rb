class UsersController < ApplicationController
  def index
    if params[:query].present?
      sql_query = " \
        user.name ILIKE :query \
        OR user.email ILIKE :query \
      "
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    end
  end

  def edit
    @user = user
  end

  def update
    @user = user
    @user.update(user_params)
    # redirect_to my_profile_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :photo, :email)
  end
end
