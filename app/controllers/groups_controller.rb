class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update]
  before_action :footer

  def index
    @groups = policy_scope(Group)
    @user = current_user
  end

  def show
    # @membership = GroupMembership.new
    if params[:query].present?
      sql_query = "name ILIKE :query OR email ILIKE :query"
      @users = policy_scope(User).where(sql_query, query: "%#{params[:query]}%")
    else
      @users = []
    end
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
    @group_membership.user = current_user
    @group_membership.save
    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
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
