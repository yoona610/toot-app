class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :destroy]

  def index
    @latest_posts = Post.page(params[:page]).per(12)
    @post_count = Post.count
  end

  def show
  end

  def destroy
    if @post.destroy
      redirect_to admin_posts_path, notice: "投稿を削除しました"
    else
      render :show, alert: "投稿を削除できませんでした"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
