# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_tracks
  has_many :products, through: :order_tracks
  accepts_nested_attributes_for :order_tracks

  validates :user, presence: true

  def calculate_taxes(subtotal)
    province = user.province
    {
      gst: (province.gst / 100.0) * subtotal,
      pst: (province.pst / 100.0) * subtotal,
      hst: (province.hst / 100.0) * subtotal,
      total_tax: ((province.gst + province.pst + province.hst) / 100.0) * subtotal
    }
  end

  def calculate_subtotal
    order_tracks.sum { |item| item.product.price * item.quantity }
  end
end
