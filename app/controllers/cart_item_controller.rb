class CartItemController < ApplicationController
	
	def create
    @cart_item = CartItem.new cart_item_param
    @cart_item.cart = current_order
    if @cart_item.save!
      redirect_to menu_path
    else
    	raise "can not add to cart"
    end
	end
  
	private
  def cart_item_param
    params.require(:cart_item).permit(:ticket_type_id,:quantity)
  end
end
