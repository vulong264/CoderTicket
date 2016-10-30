require 'rails_helper'

RSpec.feature "Upcomings", type: :feature do

  scenario "Users can see a list of upcoming events. Past events should not be shown" do
		venue = Venue.create(name:'venue',full_address:'address o day')
		cate = Category.create(name:'test')
		user = User.create(name: 'testerrun',email: 'test@live.com')
		event1 = Event.create(starts_at: 3.days.ago, 
		ends_at: 3.days.ago,
		venue_id: venue.id,
		name: "First Event EVAHHHH CAN NOT BE SHOWN",
		category_id: cate.id,
		user_id: user.id,
		published_at: Time.now)

		event2 = Event.create(starts_at: Time.now + 10.days, 
		ends_at: Time.now + 10.days,
		venue_id: venue.id,
		name: "SECOND Event EVAHHHH CAN NOT BE SHOWN",
		category_id: cate.id,
		user_id: user.id,
		published_at: Time.now)

    visit root_path

    expect(page).to have_content event2.name
  end

end