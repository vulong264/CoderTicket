class CartItem < ApplicationRecord
  belongs_to :ticket_type
  belongs_to :cart
end
