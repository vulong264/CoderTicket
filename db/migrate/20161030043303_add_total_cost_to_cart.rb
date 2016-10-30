class AddTotalCostToCart < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :total_cost, :integer
  end
end
