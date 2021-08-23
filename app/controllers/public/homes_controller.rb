class Public::HomesController < ApplicationController
  def top
    @posts = Post.where(is_draft: false)
  end

  def about
  end
end
