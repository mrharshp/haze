class GroupMembershipsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @group_membership = GroupMembership.new
    authorize @group_membership
  end

  def create
    @group = Group.find(params[:group_id])
    @user = User.find(params[:user])
    @group_membership = GroupMembership.new(group: @group, user: @user)
    authorize @group_membership
    if @group_membership.save
      redirect_to edit_group_path(@group)
    else
      redirect_to edit_group_path(@group), notice: "Member already exists!"
    end
  end
end
