class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update]

  def index
    @groups = policy_scope(Group)
  end

  def show
    authorize @group
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    @group_membership = GroupMembership.new
    authorize @group
    @group_membership.group = @group
    @group_membership.user = user
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

  end

  def group_params
    params.require(:group).permit(:name, :photo)
  end
end
