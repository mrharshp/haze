class AddCurrencyToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :currency, :string
  end
end
