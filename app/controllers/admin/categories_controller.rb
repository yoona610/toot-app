class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, except: %i[create index]
  before_action :set_category, except: %i[create index]

  def create
    @categories = Category.all
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'カテゴリが追加されました'
    else
      render :index, alert: 'カテゴリを追加できませんでした'
    end
  end

  def index
    @category = Category.new
    @categories = Category.all
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'カテゴリが変更されました'
    else
      render :edit, alert: 'カテゴリを変更できませんでした'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'カテゴリが削除されました'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
