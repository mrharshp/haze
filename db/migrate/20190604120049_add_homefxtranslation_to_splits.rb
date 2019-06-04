class AddHomefxtranslationToSplits < ActiveRecord::Migration[5.2]
  def change
    add_column :splits, :homefxtranslation, :float
  end
end
