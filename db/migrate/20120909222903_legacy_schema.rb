class LegacySchema < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.datetime :resolved_at
      t.references :update

      t.timestamps
    end

    create_table :updates do |t|
      t.text :description
      t.references :issue

      t.timestamps
    end
  end
end
