class AddMemberIdToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_comments, :member, null: false, foreign_key: true
  end
end
