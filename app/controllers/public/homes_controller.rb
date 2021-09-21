class Public::HomesController < ApplicationController
  def top
    @posts = Post.includes(:user).where(is_draft: false).order(created_at: 'DESC').limit(8)
    @post_ranks = Post.create_post_ranks.first(6)
  end

  def about; end
end
