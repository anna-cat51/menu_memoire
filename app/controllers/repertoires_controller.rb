class RepertoiresController < ApplicationController
  before_action :set_repertoire, only: %i[edit update destroy]
  def index
    @repertoires = Repertoire.all.includes(:user).order(created_at: :desc)
  end

  def new
    @repertoire = Repertoire.new
  end

  def create
    @repertoire = current_user.repertoires.new(repertoire_params)
    if @repertoire.save_with_ingredients(ingredient_names: params.dig(:repertoire, :ingredient_names).split(',').uniq)
      redirect_to repertoires_path(@repertoire), success: 'レパートリーを作成しました'
    else
      flash.now['danger'] = 'レパートリーを作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @repertoire = Repertoire.find(params[:id])
  end

  def edit;end

  def update
    @repertoire.assign_attributes(repertoire_params)
    if @repertoire.save_with_ingredients(ingredient_names: params.dig(:repertoire, :ingredient_names).split(',').uniq)
      redirect_to repertoire_path(@repertoire), success: 'レパートリーを更新しました'
    else
      flash.now[:danger] = 'レパートリーを更新できませんでした'
      render :edit
    end
  end

  def destroy
    @repertoire.destroy!
    redirect_to repertoires_path, success: '削除しました'
  end

  private

  def repertoire_params
    params.require(:repertoire).permit(:name, :recipe_url, :repertoire_image, :repertoire_image_cache)
  end

  def set_repertoire
    @repertoire = current_user.repertoires.find(params[:id])
  end
end