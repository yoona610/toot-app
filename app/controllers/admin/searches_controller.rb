class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @model = params[:model]
    @content = params[:content]
    @records = if @model == 'user'
                 User.search_for(@content)
               else
                 Post.where(is_draft: false).search_for(@content)
               end
  end
end
