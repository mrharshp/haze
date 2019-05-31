class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.references :group, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
