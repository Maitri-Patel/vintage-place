# app/models/order_track.rb
class OrderTrack < ApplicationRecord
  belongs_to :order
  belongs_to :product
 
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price_at_purchase, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
