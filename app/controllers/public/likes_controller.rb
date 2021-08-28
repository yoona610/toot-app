class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id, current_user: current_user.id)
    like.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.destroy_like(@post)
  end
end
