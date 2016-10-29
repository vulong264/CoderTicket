class EventsController < ApplicationController
  def index
		if params[:search]
			@events = Event.where("name like ? ","%"+params[:search]+"%")
		else
    	@events = Event.upcoming
		end
  end
	def new
		@event = Event.new
		@categories = Category.all
		@regions = Region.all
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
		if @event.save
			redirect_to event_path(@event.id)
		else
			flash[:error] = @event.errors.full_messages.to_sentence
			render 'new'
		end
# starts_at: datetime, ends_at: datetime, 
# venue_id: integer, hero_image_url: string, 
# extended_html_description: text, 
# category_id: integer, name: string, created_at: datetime, updated_at: datetime)
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
	private
	def event_param
		params.require(:event).permit(:all)
	end
end
