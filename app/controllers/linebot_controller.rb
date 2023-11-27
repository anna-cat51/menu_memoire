require 'line/bot'

class LinebotController < ApplicationController
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        handle_message(event)
      end
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end

  def handle_message(event)
    case event.type
    when Line::Bot::Event::MessageType::Text
      handle_text_message(event)
    end
  end

  def handle_text_message(event)
    repertoire_name = event.message['text']
    repertoire = Repertoire.find_by(name: repertoire_name)

    if repertoire
      ingredients = repertoire.ingredients.pluck(:name)
      reply_message = "料理「#{repertoire_name}」に使用されている食材は #{ingredients.join(', ')} です。"
    else
      reply_message = "料理「#{repertoire_name}」は見つかりませんでした。"
    end

    client.reply_message(event['replyToken'], { type: 'text', text: reply_message })
  end

end
