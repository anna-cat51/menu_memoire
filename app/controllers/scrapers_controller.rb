require 'mechanize'
require 'selenium-webdriver'
require 'nokogiri'

class ScrapersController < ApplicationController
  # 新しいRepertoireを作成し、それぞれのIngredientを作成または取得するメソッド∂
  def save_repertoire_ingredients(current_user, name, unique_ingredient_names)
    # 新しいRepertoireを作成
    repertoire = current_user.repertoires.create(name: name)

    # それぞれのIngredientを作成または取得
    unique_ingredient_names.each do |ingredient_name|
      ingredient = Ingredient.find_or_create_by(name: ingredient_name)

      # RepertoireとIngredientを関連付ける

      repertoire.ingredients << ingredient
    end
  end

  # ページをスクレイピングするメソッド
  def scrape_page(url)
    # Mechanize::WebDriver インスタンスを作成
    agent = Mechanize.new

    # 指定された URL にアクセス
    page = agent.get(url)

    # ページの HTML を Nokogiri で解析
    doc = Nokogiri::HTML(page.body)

    # 材料という題名の要素を取得
    # "材料" というテキストを持つ要素を探す
    # 材料という題名の要素を取得
    ingredients_container = doc.at('#ingredients_list')

    # ingredient_nameの要素を取得
    ingredient_names = ingredients_container.css('.ingredient_name .name').map(&:text)

    # 重複した要素を省く
    unique_ingredient_names = ingredient_names.uniq

    # 結果を出力
    puts '材料:'
    puts unique_ingredient_names

    # save_repertoire_ingredients メソッドを呼び出す
    save_repertoire_ingredients(current_user, params[:name], unique_ingredient_names)
  end

  # GET /scraper/index
  def index; end

  # POST /scraper/scrape
  def scrape
    @url = params[:url]

    begin
      # ページをスクレイピング
      scrape_page(@url)

      # スクレイピングが成功した場合、/repertoiresにリダイレクト
      redirect_to repertoires_path, notice: 'スクレイピングが完了しました。'
    rescue => e
      # エラーが発生した場合、エラーメッセージを設定してフォーム画面を再表示
      flash.now[:alert] = "スクレイピングに失敗しました: #{e.message}"
      render :index
    end
end
end
