require 'securerandom'

class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update]
  before_action :footer, only: [:new, :edit]

  def index
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
    if params[:query].present?
      sql_query = "name ILIKE :query OR email ILIKE :query"
      @users = policy_scope(User).where(sql_query, query: "%#{params[:query]}%")
    else
      @users = []
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

  def footer
    @footer = true
  end
end
