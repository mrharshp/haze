class AddColorToGroupMemberships < ActiveRecord::Migration[5.2]
  def change
    add_column :group_memberships, :color, :string
  end
end
