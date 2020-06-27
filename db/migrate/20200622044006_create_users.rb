class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :sex, default: "0"
      t.date :birthday
      t.integer :prefecture_code
      t.string :image, default: "public/user_images/default_image.jpg"
      t.timestamps
    end
  end
end
