class CartItemController < ApplicationController
	
	def create
	end

	def update
		@cart_item = CartItem.where(ticket_type_id: params[:ticket_type][:ticket_type_id], cart_id: current_cart.id).first
		if @cart_item
			@new_quantity = params[:ticket_type][:quantity].to_i
			@max_quantity = @cart_item.ticket_type.max_quantity.to_i
			@max_quantity_allowed = @max_quantity > 10 ? 10 : @max_quantity
			if @cart_item.quantity + @new_quantity > @max_quantity_allowed
				@cart_item.quantity = @max_quantity_allowed
				@cart_item.save
				flash[:error] = "Total ticket order exceeded, adjusted to maximum number"
			else
				@cart_item.quantity += @new_quantity 
				@cart_item.save	
			end 
			redirect_to cart_path(current_cart.id)
		else
			@cart_item = CartItem.new
			@cart_item.cart_id = current_cart.id
			@cart_item.ticket_type_id = params[:ticket_type][:ticket_type_id]
			@cart_item.quantity = params[:ticket_type][:quantity]
			if @cart_item.save
				redirect_to cart_path(current_cart.id)
			else
				flash[:error] = @cart_item.errors.full_messages.to_sentence
				redirect_to new_event_ticket_path(params[:ticket_type][:event_id])
			end
		end
	end
  
	private
  def cart_item_param
    params.require(:ticket_type).permit(:ticket_type_id,:quantity)
  end
end
