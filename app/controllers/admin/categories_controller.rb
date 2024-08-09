class Admin::CategoriesController < ApplicationController
	before_action :require_admin
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.search(params[:q])
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_category_path(@category), notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'Category was successfully deleted.'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_category_id)
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
