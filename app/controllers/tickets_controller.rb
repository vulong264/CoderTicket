class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
		@items_to_add = {}
  end
end
