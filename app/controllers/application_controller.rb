class ApplicationController < ActionController::Base
    before_action :set_ransack_search_object
    before_action :configure_permitted_parameters, if: :devise_controller?
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

    protected

def configure_permitted_parameters
  added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :address_line1, :address_line2, :city, :province_id, :postal_code]
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :address_line1, :address_line2, :city, :province_id, :postal_code])
  devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password, :address_line1, :address_line2, :city, :province_id, :postal_code])

end
end
  