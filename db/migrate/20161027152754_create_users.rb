class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: true
      t.text :password_digest

      t.timestamps
    end
  end
end
