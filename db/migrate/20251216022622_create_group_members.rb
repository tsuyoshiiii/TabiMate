class CreateGroupMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_members do |t|
      t.references :member, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  add_index :group_members, [:member_id, :group_id], unique: true
  end
end
