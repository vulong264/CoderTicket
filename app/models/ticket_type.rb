class TicketType < ActiveRecord::Base
  belongs_to :event
	has_many :cart_item 
	has_many :cart, through: :cart_item
end
