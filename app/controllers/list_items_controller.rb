class ListItemsController < ApplicationController
  before_action :find_list_item, only: [:show, :edit, :update, :destroy]

  def index
    @list_items = policy_scope(ListItem)
  end

  def show
  end

  def new
    @list_item = List_item.new
    authorize @list_item
  end

  def create
    @list_item = List_item.new(list_item_params)
    authorize @list_item
    if @list_item.save
      redirect_to group_list_path(@group, @list)
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
    redirect_to group_list_path(@group, @list)
  end

  def destroy
    @list_item.destroy
    authorize @list_item
    redirect_to group_list_path(@group, @list)
  end

  private

  def list_item_params
    params.require(:list_item).permit(:title, :url, :upvote, :downvote, :description, :photo)
  end

  def find_list_item
    @list_item = List_item.find(params[:list_item_id])
    authorize @list_item
  end
end
