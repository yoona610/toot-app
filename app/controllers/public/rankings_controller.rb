class Public::RankingsController < ApplicationController
  def index
    @post_ranks = Post.includes(:user).create_post_ranks.first(10)
  end
end
