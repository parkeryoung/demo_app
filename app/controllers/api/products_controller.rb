class Api::ProductsController < ActionController::API
  def index
    @products = Product.active
  end

  def show
    @product = Product.active.find(params[:id])
  end
end
