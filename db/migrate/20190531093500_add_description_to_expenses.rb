class AddDescriptionToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :description, :string
  end
end
