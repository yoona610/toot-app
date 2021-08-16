class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

	def index
		@model = params[:model]
		@content = params[:content]
		if @model == 'user'
			@records = User.search_for(@content)
		else
			@records = Post.search_for(@content)
		end
	end
end
