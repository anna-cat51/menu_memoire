require 'mechanize'
require 'selenium-webdriver'
require 'nokogiri'

class ScrapersController < ApplicationController
  # ページをスクレイピングするメソッド
  def scrape_page(url)
    agent = Mechanize.new
    page = agent.get(url)
    doc = Nokogiri::HTML(page.body)

    ingredients_container = doc.at('#ingredients_list')
    ingredient_names = ingredients_container.css('.ingredient_name .name').map(&:text)

    ingredient_names.uniq
  end

  # GET /scraper/index
  def index; end

  # POST /scraper/scrape
  def scrape
    @url = params[:recipe_url]

    begin
      # スクレイピングして食材名のリストを取得
      @ingredient_names = scrape_page(@url)

      # スクレイピングした食材名のリストをセッションに保存する
      session[:scraped_ingredients] = @ingredient_names

      # スクレイピング成功の通知
      redirect_to new_repertoire_path, notice: 'スクレイピングが完了しました。'
    rescue StandardError => e
      flash.now[:alert] = "スクレイピングに失敗しました: #{e.message}"
      render :index
    end
  end
end
