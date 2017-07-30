class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    assign_dates
    if @product.save
      flash[:notice] = "Successfully Saved #{@product.title}"
      redirect_to products_path
    else
      flash[:alert] = "Couldn't save #{@product.title}. "
      flash[:alert] << @product.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    assign_dates
    if @product.update_attributes(product_params)
      flash[:notice] = "Successfully Updated #{@product.title}"
      redirect_to products_path
    else
      flash[:alert] = "Couldn't update #{@product.title}. "
      flash[:alert] << @product.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  def partial_index
    @products = Product.all
    unless show_discontinued?
      @products = Product.active
    end
    render partial: 'list', locals: { products: @products }
  end

  private

  def assign_dates
    active = params[:product].delete(:active).to_i >= 1 ? true : false
    @product.start_date = Time.now if active
    @product.end_date = Date.strptime(params[:product][:end_date], Product::DATE_FORMAT)
  end

  def product_params
    params.require(:product).permit(:title, :description)
  end

  def show_discontinued?
    params[:show_discontinued] == "false" ? false : true
  end
end
