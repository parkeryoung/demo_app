class ProductsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @product = Product.new
    @catalogs = Catalog.all
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
