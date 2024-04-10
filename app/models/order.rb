# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_tracks
  has_many :products, through: :order_tracks
  accepts_nested_attributes_for :order_tracks
end
