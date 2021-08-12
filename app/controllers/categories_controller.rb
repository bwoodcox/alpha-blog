class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :find_category, only: [:show, :edit, :update]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was saved successfully."
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.udpate(category_params)
      flash[:notice] = "Category updated successfully."
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admin usrs can create categories."
      redirect_to categories_path
    end
  end

  def find_category
    @category = Category.find(params[:id])
  end
end