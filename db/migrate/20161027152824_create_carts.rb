class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :session_id
      t.references :user, foreign_key: true
      t.datetime :checked_out_at

      t.timestamps
    end
  end
end
