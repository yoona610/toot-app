class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

	def index
		@model = params[:model]
		@content = params[:content]
		if @model == 'user'
			@records = User.search_for(@content)
		else
			@records = Post.where(is_draft: false).search_for(@content)
		end
	end
end
