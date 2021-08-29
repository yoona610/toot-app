class Public::SearchesController < ApplicationController
  def index
    @content = params[:content]
    @records = Post.includes(:user).where(is_draft: false).search_for(@content)
  end
end
