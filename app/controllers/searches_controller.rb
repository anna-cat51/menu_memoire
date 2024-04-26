class SearchesController < ApplicationController
  def index
    @repertoires = @search.valid? ? @search.repertoires : []
    @repertoires = @repertoires.page(params[:page])
  end
end