class ListsController < ApplicationController
  before_action :find_group
  before_action :find_list, only: [:edit, :update, :destroy, :show]
  before_action :footer, only: [:index, :show, :new, :edit]

  def index
    @list = List.new
    @lists = policy_scope(List).where(group: @group)
  end

  def show
    @list_item = ListItem.new
    @group = Group.find(params[:group_id])
    @list = List.find(params[:id])
    @list_items = ListItem.where(list: @list)
    authorize @list
  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.group = @group
    @list.user = current_user
    authorize @list
    if @list.save
      redirect_to group_lists_path(@group)
    else
      render :new
    end
  end

  def edit
    authorize @list
  end

  def update
    @list.update(list_params)
    authorize @list
    redirect_to group_lists_path(@group)
  end

  def destroy
    @list.destroy
    authorize @list
    redirect_to group_lists_path(@group)
  end

  private

  def find_list
    @list = List.find(params[:id])
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def list_params
    params.require(:list).permit(:name, :photo, :group_id)
  end

  def footer
    @footer = true
  end
end
