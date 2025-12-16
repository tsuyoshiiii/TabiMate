class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :introduction
      t.integer :owner_id, null: false 

      t.timestamps
    end
    add_index :groups, :name, unique: true 
    add_foreign_key :groups, :members, column: :owner_id
  end
end
