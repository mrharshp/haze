class CreateSplits < ActiveRecord::Migration[5.2]
  def change
    create_table :splits do |t|
      t.references :expense, foreign_key: true
      t.references :user, foreign_key: true
      t.float :customsplit

      t.timestamps
    end
  end
end
