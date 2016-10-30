class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
		@items_to_add = {}
  end
	def add_to_cart(cart_items = {})
	end
end
