class EventsController < ApplicationController
	before_action :check_event_changing_permission

	def check_event_changing_permission
		if params[:id]
			@event = Event.find(params[:id])
			if @event.user_id != current_user.id
				flash[:error] = "Permission denied. You are not the creator of this event!"
			end
		end
	end 

  def index
		if params[:search]
			@events = Event.where("name like ? AND published_at is not null","%"+params[:search]+"%")
		else
    	@events = Event.upcoming
		end
  end

	def mine
		@events = Event.where(user_id: current_user.id)
	end

	def new
		@event = Event.new

	end
	def create
		#create venue
		@venue = Venue.find_or_create_by(name: params[:event][:venue_name],
		full_address: params[:event][:venue_address],
		region_id: params[:event][:region_id])
		#create event
		@event = Event.new
		@event.starts_at = Date.parse(get_starts_at(params[:event]).to_s)
		@event.ends_at = Date.parse(get_ends_at(params[:event]).to_s)
		@event.venue_id = @venue.id
		@event.hero_image_url = params[:event][:hero_image_url]
		@event.extended_html_description = params[:event][:extended_html_description]
		@event.category_id = params[:event][:category_id]
		@event.name = params[:event][:name]
		@event.user_id = current_user.id
		if @event.save
			redirect_to event_path(@event.id)
		else
			flash[:error] = @event.errors.full_messages.to_sentence
			render 'new'
		end
	end

  def show
    @event = Event.find(params[:id])
  end

	def get_starts_at(hash)
		@date = %w(1 2 3).map { |e| hash["starts_at(#{e}i)"].to_i }.join('-')
		@time = %w(4 5).map { |e| hash["starts_at(#{e}i)"].to_i }.join(':')
		@date + " " + @time
	end

	def get_ends_at(hash)
		@date = %w(1 2 3).map { |e| hash["ends_at(#{e}i)"].to_i }.join('-')
		@time = %w(4 5).map { |e| hash["ends_at(#{e}i)"].to_i }.join(':')
		@date + " " + @time
	end

	def publish
		@event = Event.find(params[:id])
		@event.published_at = Time.now
		if @event.save
			flash[:success] = "Event Published"
			redirect_to event_path(@event.id)
		else
			flash[:error] = @event.errors.full_messages.to_sentence
			redirect_to event_path(@event.id)
		end
	end

	def update
		#create venue
		@venue = Venue.find_or_create_by(name: params[:event][:venue_name],
		full_address: params[:event][:venue_address],
		region_id: params[:event][:region_id])
		#create event
		@event.starts_at = Date.parse(get_starts_at(params[:event]).to_s)
		@event.ends_at = Date.parse(get_ends_at(params[:event]).to_s)
		@event.venue_id = @venue.id
		@event.hero_image_url = params[:event][:hero_image_url]
		@event.extended_html_description = params[:event][:extended_html_description]
		@event.category_id = params[:event][:category_id]
		@event.name = params[:event][:name]
		@event.user_id = current_user.id
		if @event.save
			flash[:success] = "Event updated successfully!"
			redirect_to event_path(@event.id)
		else
			flash[:error] = @event.errors.full_messages.to_sentence
			redirect_to 'edit'
		end
	end

	def add_ticket
               @event = Event.find(params[:id])
               @ticket_type = TicketType.new
               @ticket_type.event_id = @event.id
               @ticket_type.name = params[:event][:ticket_name]
               @ticket_type.price = params[:event][:ticket_price]
               @ticket_type.max_quantity = params[:event][:ticket_max]
               if @ticket_type.save
                       flash[:success] = "Event Published"
                       redirect_to event_path(@event.id)
               else
                       flash[:error] = @ticket_type.errors.full_messages.to_sentence
                       redirect_to event_path(@event.id)
               end 
	end
	private

	def event_param
		params.require(:event).permit(:ticket_type,:event_id)
	end
end
