class SearchesController < ApplicationController
  def index
    @repertoires = @search.valid? ? @search.repertoires : []
  end
end