class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :photo
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
