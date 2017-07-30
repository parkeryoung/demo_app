class RatePlansController < ApplicationController
  before_action :load_products, only: [:new, :edit]
  def index
    @rate_plans = RatePlan.all
  end

  def show
    @rate_plan = RatePlan.find(params[:id])
  end

  def new
    @rate_plan = RatePlan.new
  end

  def create
    @rate_plan = RatePlan.new(rate_plan_params)
    assign_dates
    if @rate_plan.save
      flash[:notice] = "Successfully Saved #{@rate_plan.title}"
      redirect_to rate_plans_path
    else
      flash[:alert] = "Couldn't save #{@rate_plan.title}. "
      flash[:alert] << @rate_plan.errors.full_messages.to_sentence
      load_products
      render 'new'
    end
  end

  def edit
    @rate_plan = RatePlan.find(params[:id])
  end

  def update
    @rate_plan = RatePlan.find(params[:id])
    assign_dates
    if @rate_plan.update_attributes(rate_plan_params)
      flash[:notice] = "Successfully updated #{@rate_plan.title}"
      redirect_to rate_plans_path
    else
      flash[:alert] = "Couldn't update #{@rate_plan.title}. "
      flash[:alert] << @rate_plan.errors.full_messages.to_sentence
      load_products
      render 'edit'
    end
  end

  def delete
    @rate_plan = RatePlan.find(params[:id])
    @rate_plan.destroy
    redirect_to rate_plans_path
  end

  private

  def assign_dates
    @rate_plan.start_date = Date.strptime(params[:rate_plan][:start_date], RatePlan::DATE_FORMAT)
    @rate_plan.end_date = Date.strptime(params[:rate_plan][:end_date], RatePlan::DATE_FORMAT)
  end

  def rate_plan_params
    params.require(:rate_plan).permit(:title, :description, :recurrence, :price)
  end

  def load_products
    @products = Product.all
  end
end
