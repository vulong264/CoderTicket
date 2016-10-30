class TicketsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
		render 'show'
  end
end
