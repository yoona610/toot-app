class Public::SearchesController < ApplicationController
	def index
		@content = params[:content]
		@records = Post.where(is_draft: false).search_for(@content)
	end
end
