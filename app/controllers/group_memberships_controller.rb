class GroupMembershipsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @group_membership = GroupMembership.new
    authorize @group_membership
  end
end
