class CreateListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :list_items do |t|
      t.string :title
      t.string :url
      t.text :description
      t.string :photo
      t.integer :upvote, default: 0
      t.integer :downvote, default: 0
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
