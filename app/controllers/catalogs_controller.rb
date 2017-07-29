class CatalogsController < ApplicationController
  def index
    @catalogs = Catalog.all
  end

  def show
    @catalog = Catalog.find(params[:id])
  end

  def new
    @catalog = Catalog.new
  end

  def create
    @catalog = Catalog.new(catalog_params)
    if @catalog.save
      flash[:success] = "#{@catalog.name} Successfully Saved"
      redirect_to catalogs_path
    else
      flash[:error] = "Catalog could not be created."
      flash[:error] << @catalog.errors.messages.to_sentence.join(" ")
      render 'new'
    end
  end

  def edit
    @catalog = Catalog.find(params[:id])
  end

  def update
    @catalog = Catalog.find(params[:id])
    if @catalog.update_attributes(catalog_params)
      flash[:success] = "#{@catalog.name} Successfully Saved"
      redirect_to catalogs_path
    else
      flash[:error] = "Catalog could not be created."
      flash[:error] << @catalog.errors.messages.to_sentence.join(" ")
      render 'edit'
    end
  end

  def destroy
  end

  private
    def catalog_params
      params.require(:catalog).permit(:name)
    end
end
