class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :image_url
      t.boolean :disclaimer_agreement
      t.boolean :terms_and_conditions_agreement

      t.timestamps
    end
  end
end
