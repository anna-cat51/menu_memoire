class RepertoiresController < ApplicationController
  def index
    @repertoires = Repertoire.all.includes(:user).order(created_at: :desc)
  end
end
