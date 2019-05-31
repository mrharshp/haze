class AddSettledToSplits < ActiveRecord::Migration[5.2]
  def change
    add_column :splits, :settled, :boolean, default: false
  end
end
