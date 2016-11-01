class CartsController < ApplicationController
	def show
		@user = User.find(current_user.id)
		@cart = Cart.find(current_cart.id)
		@cart_items = CartItem.where(cart_id: current_cart.id)
		@total_price = 0
		@cart_items.each do |item|
			@total_price += item.ticket_type.price.to_i * item.quantity.to_i
		end
	end

	def checkout
		@cart = Cart.find(current_cart.id)
		@cart.checked_out_at = Time.now
		@cart.save
		redirect_to root_path
	end

	def add_ticket
		params[:cart][:ticket_type].values.each do |ticket|
				@cart_item = CartItem.where(ticket_type_id: ticket[:id], cart_id: current_cart.id).first
				if @cart_item
					@new_quantity = ticket[:quantity].to_i
					@max_quantity = @cart_item.ticket_type.max_quantity.to_i
					@max_quantity_allowed = @max_quantity > 10 ? 10 : @max_quantity
					if @cart_item.quantity.to_i + @new_quantity > @max_quantity_allowed
						@cart_item.quantity = @max_quantity_allowed
						@cart_item.save
						flash[:error] = "Total ticket order exceeded, adjusted to maximum number"
					else
						@cart_item.quantity = @cart_item.quantity.to_i + @new_quantity 
						@cart_item.save	
					end 
				else
					@cart_item = CartItem.new
					@cart_item.cart_id = current_cart.id
					@cart_item.ticket_type_id = ticket[:id]
					@cart_item.quantity = ticket[:quantity]
					if @cart_item.save
						flash[:success] = "Added to cart"
					else
						flash[:error] = @cart_item.errors.full_messages.to_sentence
						redirect_to new_event_ticket_path(params[:cart][:event_id])
					end
				end
		end
		redirect_to cart_path(current_cart.id)
	end
	
end
