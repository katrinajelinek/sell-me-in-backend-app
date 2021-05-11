class AddBoughtToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :bought, :boolean, default: false
  end
end
