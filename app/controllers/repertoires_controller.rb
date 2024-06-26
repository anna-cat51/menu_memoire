class RepertoiresController < ApplicationController
  before_action :set_repertoire, only: %i[show edit update destroy]
  before_action :check_ownership, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @repertoires = Repertoire.of_user(current_user).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @repertoire = Repertoire.find(params[:id])
  end

  def new
    @repertoire = Repertoire.new
  end

  def edit; end

  def create
    @repertoire = current_user.repertoires.new(repertoire_params_without_ingredient_names)
    if @repertoire.save_with_ingredients(ingredient_names: extracted_ingredient_names)
      redirect_to repertoires_path, success: 'レパートリーを作成しました'
    else
      flash.now[:alert] = 'レパートリーを作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    ingredients_attributes = params[:repertoire][:ingredients_attributes]
    if @repertoire.save_with_ingredients(ingredient_names: extracted_ingredient_names)
      @repertoire.destroy_with_ingredients(ingredients_attributes: ingredients_attributes)
      redirect_to repertoire_path(@repertoire), success: 'レパートリーを更新しました'
    else
      flash.now[:alert] = 'レパートリーを更新できませんでした'
      render :edit
    end
  end

  def destroy
    @repertoire.destroy!
    redirect_to repertoires_path, success: '削除しました'
  end

  def scrape
    @url = params[:recipe_url]
    begin
      # スクレイピングして食材名のリストを取得
      @ingredient_names = scrape_page(@url)

      # スクレイピングした食材名のリストをセッションに保存する
      session[:scraped_ingredients] = @ingredient_names

      render json: { ingredients: @ingredient_names }

      # スクレイピング成功の通知
    rescue StandardError => e
      flash.now[:alert] = "スクレイピングに失敗しました: #{e.message}"
      render :index
    end
  end

  private

  def repertoire_params_without_ingredient_names
    repertoire_params.except(:ingredient_names)
  end

  def extracted_ingredient_names
    ingredient_names = params.dig(:repertoire, :ingredient_names).to_s.split(',').map(&:strip).uniq
    ingredients_from_attributes = params.dig(:repertoire, :ingredients_attributes)&.values&.map { |v| v[:name] }&.uniq || []
    ingredient_names + ingredients_from_attributes
  end

  def repertoire_params
    params.require(:repertoire).permit(
      :name,
      :recipe_url,
      :repertoire_image,
      :repertoire_image_cache,
      :ingredient_names,
      ingredients_attributes: [:id, :name, :_destroy]
    )
  end


  def set_repertoire
    @repertoire = current_user.repertoires.find(params[:id])
  end

  def check_ownership
    redirect_to(root_url, alert: 'このページにアクセスする権限がありません') unless @repertoire.user == current_user
  end

  # スクレイピングを行うメソッド
  def scrape_page(url)
    agent = Mechanize.new
    page = agent.get(url)
    doc = Nokogiri::HTML(page.body)

    ingredients_container = doc.at('#ingredients_list')
    ingredient_names = ingredients_container.css('.ingredient_name .name').map(&:text)

    ingredient_names.uniq
  end
end
