class ListItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :create, :destroy]

  def show
    @list_item.user = user
    @list = List.find(params[:list_id])
    @list_item = List_item.find(params[:list_item_id])
  end

  def new
    @list_item = List_item.new
    authorize @list_item
  end

  def create
    @list_item = List_item.new
    authorize @list_item
    @list_item.user = user
    @list = List.find(params[:list_id])
    if @list_item.save
      redirect_to group_list_path(@list)
    else
      render :new
    end
  end

  def edit
    authorize @list_item
  end

  def update
    @list = List.find(params[:list_id])
    if @list_item.user == user
      @list_item.update(list_item_params)
      authorize @list_item
      redirect_to group_list_path(@list)
  end


  def destroy
    if @list_item.user == user
    @list_item.destroy
    authorize @list_item
    redirect_to group_list_path(@list)
    end
  end

  private

  def list_item_params
    params.require(:list_item).permit(:title, :url, :upvote, :downvote, :description, :photo)
    authorize @list_item
  end
end
