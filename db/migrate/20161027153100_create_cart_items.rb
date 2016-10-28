class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity
      t.references :ticket_type, foreign_key: true
      t.references :cart, index: true, foreign_key: true
      t.timestamps
    end
  end
end
