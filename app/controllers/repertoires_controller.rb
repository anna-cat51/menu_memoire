class RepertoiresController < ApplicationController
  def index
    @repertoires = Repertoire.all.includes(:user).order(created_at: :desc)
  end

  def new
    @repertoire = Repertoire.new
  end

  def create
    @repertoire = current_user.repertoires.new(repertoire_params)
    if @repertoire.save
      redirect_to repertoires_path, success: '保存成功'
    else
      flash.now['danger'] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @repertoire = Repertoire.find(params[:id])
  end

  private

  def repertoire_params
    params.require(:repertoire).permit(:name, :recipe_url)
  end
end