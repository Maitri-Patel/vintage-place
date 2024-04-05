# app/controllers/cart_controller.rb
class CartController < ApplicationController
    before_action :set_product, only: [:add_item, :update_item, :remove_item]
  
    def show
        @cart_items = current_cart.map do |product_id_str, quantity|
          product_id = product_id_str.to_i
          product = Product.find_by(id: product_id) # Use find_by to avoid exceptions if the ID doesn't exist
          [product, quantity] if product # Make sure to add it to @cart_items only if the product was found
        end.compact # Remove nil elements in case some products weren't found
      end
      
  
    def add_item
        product_id = @product.id.to_s
        quantity = params[:quantity].to_i
      
        current_cart[product_id] = current_cart.fetch(product_id, 0) + quantity
        redirect_to cart_path, notice: 'Item added to cart.'
      end
  
    def update_item
        product_id = params[:product_id].to_s
        quantity = params[:quantity].to_i
        current_cart[product_id] = quantity if quantity > 0
        redirect_to cart_path, notice: 'Cart updated.'
    end
  
    def remove_item
        product_id = params[:product_id].to_s
        current_cart.delete(product_id)
        redirect_to cart_path, notice: 'Item removed from cart.'
    end
  
    private
  
    def set_product
      @product = Product.find(params[:product_id])
    end
  end
  