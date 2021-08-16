class Public::SearchesController < ApplicationController
	def index
		@content = params[:content]
		@records = Post.search_for(@content)
	end
end
