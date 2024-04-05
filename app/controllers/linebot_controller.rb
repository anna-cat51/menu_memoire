require 'line/bot'

class LinebotController < ApplicationController
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          # 条件分岐
          handle_text_message(event)

          message = {
            type: 'text',
            text: @response
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET')
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN')
    end
  end

  def handle_text_message(event)
    # LINEのイベントからユーザーIDを取得し、等しいUserを検索する
    @user = User.find_by(provider: 'line', uid: event['source']['userId'])
    text = event.message['text']

    case @user.status
    when 'top'
      case text
      when /料理/
        @user.update(status: 'waiting_for_input_for_repertoire')
        @response = '検索したい料理名を入力してください。'
      when /材料/
        @user.update(status: 'waiting_for_input_for_ingredient')
        @response = '検索したい材料名を入力してください。'
      else
        show_search_options
      end
    when 'waiting_for_choice'
      process_search_choice(text)
    when 'waiting_for_input_for_repertoire'
      @response = search_by_repertoire(text)
      @user.update(status: 'top')
    when 'waiting_for_input_for_ingredient'
      @response = search_by_ingredient(text)
      @user.update(status: 'top')
    end
    client.reply_message(event['replyToken'], { type: 'text', text: @response })
  end

  def show_search_options
    @response = "何を検索する？\n1: 料理名から使っている材料を検索する\n2: 材料からなにが作れるか検索する"
    @user.update(status: 'waiting_for_choice')
  end

  def process_search_choice(choice)
    case choice
    when '1'
      @user.update(status: 'waiting_for_input_for_repertoire')
      @response = '検索したい料理名を入力してください。'
    when '2'
      @user.update(status: 'waiting_for_input_for_ingredient')
      @response = '検索したい材料名を入力してください。'
    else
      @response = '無効な選択です。もう一度選択してください。'
      show_search_options
    end
  end

  def search_by_repertoire(repertoire_name)
    # 料理名から材料を検索するロジック
    search_contents = SearchContent.search(repertoire_name)
    repertoire_ids = search_contents.pluck(:repertoire_id).uniq.compact
  
    ingredients = Ingredient.where(id: ingredient_ids).where(user: @user)

    if ingredients.any?
      ingredient_names = ingredients.pluck(:name).join(', ')
      @response = "「#{repertoire_name}」に使用されている食材は #{ingredient_names} です。"
    else
      @response = "「#{repertoire_name}」に関連する食材は見つかりませんでした。"
    end
  end

  def search_by_ingredient(ingredient_name)
    # 材料名からつくれる料理を検索するロジック
    search_contents = SearchContent.search(ingredient_name)
    repertoire_ids = search_contents.pluck(:repertoire_id).uniq.compact
    repertoires = Repertoire.where(id: repertoire_ids).where(user: @user)

    if repertoires.any?
      repertoire_names = repertoires.pluck(:name).join(', ')
      @response = "#{ingredient_name} を使用した料理は #{repertoire_names} です。"
    else
      @response = "#{ingredient_name} を使用した料理は見つかりませんでした。"
    end
  end
end
