class AddPaidToSplits < ActiveRecord::Migration[5.2]
  def change
    add_column :splits, :paid, :boolean
  end
end
