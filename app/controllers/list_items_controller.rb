class ListItemsController < ApplicationController
  before_action :find_list_item, only: [:show, :edit, :update, :destroy]
  before_action :footer, only: [:edit, :new]

  def index
    @list_items = policy_scope(ListItem)
  end

  def show
  end

  def new
    @group = Group.find(params[:group_id])
    @list = List.find(params[:list_id])
    @list_item = ListItem.new
    @list_item.user = current_user
    authorize @list_item
  end

  def create
    @group = Group.find(params[:group_id])
    @list = List.find(params[:list_id])
    @list_item = ListItem.new(list_item_params)
    @list_item.list = @list
    @list_item.user = current_user
    authorize @list_item
    if @list_item.save
      redirect_to group_list_path(@group, @list)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @list = List.find(params[:list_id])
    authorize @list_item
  end

  def update
    @group = Group.find(params[:group_id])
    @list = List.find(params[:list_id])
    @list_item.update(list_item_params)
    authorize @list_item
    redirect_to group_list_path(@group, @list)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @list = List.find(params[:list_id])
    @list_item.destroy
    authorize @list_item
    redirect_to group_list_path(@group, @list)
  end

  private

  def list_item_params
    params.require(:list_item).permit(:title, :url, :upvote, :downvote, :description, :photo)
  end

  def find_list_item
    @list_item = ListItem.find(params[:id])
    authorize @list_item
  end

  def footer
    @footer = true
  end
end
