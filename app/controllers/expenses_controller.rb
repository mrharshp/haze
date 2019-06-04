require 'open-uri'
require 'json'

class ExpensesController < ApplicationController
before_action :find_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = policy_scope(Expense)
    @splits = policy_scope(Split)
    @group = Group.find(params[:group_id])
  end

  def show
  end

  def new
    @expense = Expense.new
    @group = Group.find(params[:group_id])
    @expense.group = @group
    authorize @expense
    find_currencies
  end

  def create
    find_currencies
    @expense = Expense.new
    @group = Group.find(params[:group_id])
    @expense.group = @group
    @expense.description = params[:description]
    @expense.value = params[:amount]
    @expense.currency = params[:currency]
    authorize @expense
    @paid_by_users = params[:paid_by][:user_ids].drop(1)
    @split_between_users = params[:split_between][:user_ids].drop(1)
    if @expense.save
      params[:split_between][:user_ids].drop(1).each do |u|
        member = u.to_i
        @split = Split.new
        @split.expense = @expense
        @split.user = User.find(member)
        @split.customsplit = (1 / (params[:split_between][:user_ids].length - 1).to_f)
        @split.paid = false
        if params[:paid_by][:user_ids].drop(1).include?(member.to_s)
          @split.paid = true
        end
        authorize @split
        @split.save!
      end
      redirect_to(group_expenses_path(@group) + "?paid=#{@paid_by_users}&split=#{@split_between_users}")
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    find_currencies
    @currencies = []
    @final_currency.each do |currency|
      @currencies << "#{currency[:symbol]}: #{currency[:country]}"
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @expense.update(expense_params)
    redirect_to group_expenses_path(@group)
    find_currencies
    @currencies = []
    @final_currency.each do |currency|
      @currencies << "#{currency[:symbol]}: #{currency[:country]}"
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @expense.destroy
    redirect_to group_expenses_path(@group)
  end

  private

  def find_expense
    @expense = Expense.find(params[:id])
    authorize @expense
  end

  def expense_params
    params.require(:expense).permit(:value, :currency, :description)
  end

  def find_currencies
    url = 'https://openexchangerates.org/api/currencies.json?app_id='
    currency = JSON.parse(open(url).read)
    @final_currency = []
    currency.map do |cu, country|
      @final_currency << { country: country, symbol: cu }
    end
  end
end
