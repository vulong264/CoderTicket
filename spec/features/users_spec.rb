require 'rails_helper'

RSpec.feature "Users", type: :feature do
  
  scenario "user can login with email and password" do
    visit new_session_path

    expect(page).to have_content 'Email'
  end
	
end
