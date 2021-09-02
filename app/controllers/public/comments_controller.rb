class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    { current_user: current_user.id, comment: params[:comment][:comment], rate: params[:comment][:rate] }
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comments = Comment.includes(:post, :user).where(post_id: params[:post_id]).order(id: :desc)
  end
end
