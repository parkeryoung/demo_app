class Api::ProductsController < ActionController::API
  def index
    @products = Product.active
  end

  def show
    @product = Product.find(params[:id])
  end
end
