# app/models/order_track.rb
class OrderTrack < ApplicationRecord
  belongs_to :order
  belongs_to :product
  # Add any additional fields you need here, such as quantity or item price
end
