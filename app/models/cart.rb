class Cart < ApplicationRecord
	attr_accessor :quantity
  belongs_to :user
	has_many :cart_item 
	has_many :ticket_type, through: :cart_item
end
