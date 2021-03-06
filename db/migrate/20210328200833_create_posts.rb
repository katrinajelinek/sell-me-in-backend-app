class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :video_url
      t.string :price
      t.string :location

      t.timestamps
    end
  end
end
