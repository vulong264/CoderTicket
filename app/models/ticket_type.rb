class TicketType < ActiveRecord::Base
	attr_accessor :quantity
  belongs_to :event
	has_many :cart_item 
	has_many :cart, through: :cart_item
	validates_presence_of :price, :name, :max_quantity
  validates_uniqueness_of :name
end
