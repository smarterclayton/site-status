class AddScheduledIssue < ActiveRecord::Migration
  def up
    remove_column :issues, :update_id

    add_column :issues, :begins_at, :datetime
    add_column :issues, :ends_at, :datetime
    add_column :issues, :timezone, :string

    add_column :issues, :type, :string
  end

  def down
    add_column :issues, :update_id, :integer

    remove_column :issues, :begins_at, :datetime
    remove_column :issues, :ends_at, :datetime
    remove_column :issues, :timezone, :string

    remove_column :issues, :type, :string
  end
end
