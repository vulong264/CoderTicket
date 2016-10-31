require 'rails_helper'

RSpec.describe Event, type: :model do
  	describe ".upcoming" do 
		it "Users can see a list of upcoming events. Past events should not be shown" do
		venue = Venue.create!(name:'venue',full_address:'address o day')
		cate = Category.create!(name:'Entertainment')
		user = User.create!(name: 'testerrun',email: 'test@live.com',password: 'abcd')

			event1 = Event.create!(starts_at: 3.days.ago, 
			ends_at: 3.days.ago,
			venue_id: venue.id,
			name: "First Event EVAHHHH CAN NOT SHOW",
			category_id: cate.id,
			user_id: user.id,
			published_at: Time.now,
			extended_html_description: 'Test')

			event2 = Event.create!(starts_at: Time.now + 10.days, 
			ends_at: Time.now + 10.days,
			venue: Venue.new,
			name: "SECOND Event CAN BE SHOWN",
			category: Category.new,
			user_id: user.id,
			published_at: Time.now,
			extended_html_description: 'Test')
			
			expect(Event.upcoming).to eq [event2]
		end

		
	end 
end
