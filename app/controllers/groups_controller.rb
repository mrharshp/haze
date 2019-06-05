require 'securerandom'

class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update]
  skip_after_action :verify_authorized, only: :invite
  # before_action :footer, only: [:new]

  def index
    @group = Group.new
    @groups = policy_scope(Group)
    @user = current_user
  end

  def show
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    authorize @group
    @group_membership = GroupMembership.new
    @group_membership.group = @group
    @group_membership.color = "##{SecureRandom.hex(3)}"
    @group_membership.user = current_user
    @group_membership.save
    if @group.save
      Conversation.create(group: @group)
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @user = current_user
    if params[:query].present?
      sql_query = "name ILIKE :query OR email ILIKE :query"
      @users = policy_scope(User).where(sql_query, query: "%#{params[:query]}%")
    else
      @users = []
    end
   end

  def invite
   if params["friend_email"].present?
    @friend_email = params["friend_email"]
    @group_id = params["group_id"]
    UserMailer.with(friend_email: @friend_email, sender_name: current_user.name, group_id: @group_id).invite.deliver_now
    flash[:notice] = "Email has been sent!"
    redirect_to edit_group_path(@group_id)
   end
  end

  def update
    authorize @group
    @group.update(group_params)
    redirect_to group_path(@group)
  end

  private

  def find_group
    @group = Group.find(params[:id])
    authorize @group
  end

  def group_params
    params.require(:group).permit(:name, :photo)
  end

  # def footer
  #   @footer = true
  # end
end
