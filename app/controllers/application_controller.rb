class ApplicationController < ActionController::Base
    before_action :set_ransack_search_object
    helper_method :current_cart, :cart_total
  
    private
  
    def set_ransack_search_object
      @q = Product.ransack(params[:q])
    end
  
    def current_cart
      session[:cart] ||= Hash.new(0) 
    end
  
    def cart_total
      current_cart.sum { |item_id, quantity| Product.find(item_id).price * quantity }
    end
  end
  