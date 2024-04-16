class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
    @cart_items = get_cart_items
    @subtotal = calculate_subtotal(@cart_items)
    @tax_details = @order.calculate_taxes(@subtotal)
    @total_with_taxes = @subtotal + @tax_details[:total_tax]
  end

  def show
    @order = Order.find(params[:id])
    @tax_details = @order.calculate_taxes(@order.calculate_subtotal)
    @subtotal = @order.calculate_subtotal
    @total_with_taxes = @subtotal + @tax_details[:total_tax]
  end

  def create
    @order = current_user.orders.build(order_params)
    @cart_items = get_cart_items
    build_order_tracks

    if @order.save
      flash[:notice] = 'Order placed successfully!'
      redirect_to order_path(@order)
    else
      flash.now[:alert] = 'Failed to place the order.'
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:total_price, :tax_amount)
  end

  def build_order_tracks
    @cart_items.each do |product, quantity|
      @order.order_tracks.build(product: product, quantity: quantity, price_at_purchase: product.price)
    end
  
    # Assuming calculate_subtotal is a controller method that calculates the subtotal
    @order.total_price = calculate_subtotal(@cart_items)
    
    # Assuming calculate_taxes is an Order model method that calculates the tax based on subtotal and province
    tax_details = @order.calculate_taxes(@order.total_price)
    @order.tax_amount = tax_details[:total_tax]
  end
  
  def get_cart_items
    session[:cart].map do |product_id, quantity|
      product = Product.find(product_id)
      [product, quantity] if product
    end.compact
  end

  def calculate_subtotal(cart_items)
    cart_items.sum { |product, quantity| product.price * quantity }
  end
end
