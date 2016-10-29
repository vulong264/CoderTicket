class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
		@order_items = {}
  end
	def add_to_cart(cart_item = {})
	end
end
