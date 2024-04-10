class OrdersController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @order = Order.new
      @cart_items = get_cart_items
      @subtotal = calculate_subtotal(@cart_items)
      @estimated_tax = calculate_tax(@subtotal)
    end

    def show
      @order = Order.find(params[:id]) # Make sure this line is correctly finding the order
    end
  
    def create
      @order = current_user.orders.build(order_params)
      @cart_items = get_cart_items
      build_order_tracks
  
      if @order.save
         # session[:cart] = {} Clear the cart after successfully creating an order
        redirect_to @order, notice: 'Your order was successfully placed.'
      else
        render :new
      end
    end
    
    private
    
    def order_params
      params.require(:order).permit(:total_price, :tax_amount)
    end
    
    def build_order_tracks
      total_price = 0
      @cart_items.each do |product, quantity|
        subtotal = product.price * quantity
        total_price += subtotal
        @order.order_tracks.build(product: product, quantity: quantity, price_at_purchase: product.price)
      end
      @order.total_price = total_price
      @order.tax_amount = calculate_tax(total_price) # Calculate the tax based on total price
    end
    
    def get_cart_items
      session[:cart].map do |product_id_str, quantity|
        product = Product.find_by(id: product_id_str.to_i)
        [product, quantity] if product
      end.compact
    end

    def calculate_subtotal(cart_items)
      cart_items.sum { |product, quantity| product.price * quantity }
    end
  
    def calculate_tax(subtotal)
      tax_rate = current_user.province.tax_rate / 100.0
      subtotal * tax_rate
    end
   
    
    # Use this method to whitelist address-related parameters.
    def address_params
      params.require(:user).permit(:address_line1, :city, :province_id, :postal_code)
    end
  end
  