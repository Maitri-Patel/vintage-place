class ProductsController < ApplicationController
  def index
    # Initialize the Ransack search object
    @q = Product.ransack(params[:q])

    # Initialize @products based on category filter or all products
    @products = if params[:category_id]
                  Category.find(params[:category_id]).products
                else
                  Product.all
                end

    # Apply Ransack search and additional filters on the filtered products
    @products = @products.on_sale if params[:on_sale].present?
    @products = @products.new_products if params[:new].present?
    @products = @products.recently_updated if params[:recently_updated].present?

    # Finally, apply Ransack search and paginate the results
    @products = @q.result(distinct: true).where(id: @products.select(:id)).page(params[:page]).per(9)
  end

  def show
    @product = Product.find(params[:id])
    # This line is not necessary for show action unless you have a search form on the show page as well
    @q = Product.ransack(params[:q]) 
  end
end
