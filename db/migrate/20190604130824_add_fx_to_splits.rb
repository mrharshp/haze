class AddFxToSplits < ActiveRecord::Migration[5.2]
  def change
    add_column :splits, :fx, :float
  end
end
