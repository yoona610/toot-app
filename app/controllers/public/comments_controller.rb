class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(current_user: current_user.id, comment: params[:comment][:comment])
    @comment.post_id = @post.id
    @comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    # params.require(:comment).permit(:comment)
    { current_user: current_user.id, comment: params[:comment][:comment] }
  end
end
