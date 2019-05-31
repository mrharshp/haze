class ExpensesController < ApplicationController
before_action :find_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = policy_scope(Expense)
    @splits = policy_scope(Split)
  end

  def show
  end

  def new
    @expense = Expense.new
    @group = Group.find(params[:group_id])
    @expense.group = @group
    authorize @expense
  end

  def create
    # raise
    @expense = Expense.new
    @group = Group.find(params[:group_id])
    @expense.group = @group
    @expense.description = params[:description]
    @expense.value = params[:amount]
    @expense.currency = params[:currency]
    authorize @expense
    if @expense.save
      params[:split_between][:user_ids].drop(1).each do |u|
        member = u.to_i
        @split = Split.new
        @split.expense = @expense
        @split.user = User.find(member)
        @split.customsplit = 1 / (params[:split_between][:user_ids].count - 1)
        if params[:paid_by][:user_ids].drop(1).include?(member.to_s)
          @split.paid = true
        else
          @split.paid = false
        end
        authorize @split
        @split.save
      end
      redirect_to group_expenses_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def find_expense
    @expense = Expense.find(params[:id])
    authorize @expense
  end

  # def expense_params
  #   params.require(:expense).permit(:description, :value, :currency)
  # end

  # def find_split
  #   @split = Split.find(params[:id])
  #   authorize @split
  # end

  def footer
    @footer = true
  end
end
