class ListItemsController < ApplicationController
  before_action :find_list_item, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  # before_action :footer, only: [:edit, :new]
  before_action :find_group, only: [:new, :edit]
  before_action :find_list, only: [:new, :create, :edit, :update, :destroy]

  def index
    @list_items = policy_scope(ListItem)
  end

  def show
  end

  def new
    @list_item = ListItem.new
    @list_item.user = current_user
    authorize @list_item
  end

  def create
    @list_item = ListItem.new(list_item_params)
    @list_item.list = @list
    @list_item.user = current_user
    authorize @list_item
    if @list_item.save
      redirect_to group_list_path(@list.group, @list)
    else
      render :new
    end
  end

  def edit
    authorize @list_item
  end

  def update
    @list_item.update(list_item_params)
    authorize @list_item
    redirect_to group_list_path(@list.group, @list)
  end

  def destroy
    @list_item.destroy
    authorize @list_item
    redirect_to group_list_path(@list.group, @list)
  end

  private

  def list_item_params
    params.require(:list_item).permit(:title, :url, :upvote, :downvote, :description, :photo)
  end

  def find_list_item
    @list_item = ListItem.find(params[:id])
    authorize @list_item
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def find_list
    @list = List.find(params[:list_id])
  end

  # def footer
  #   @footer = true
  # end
end
