require 'slack-ruby-bot'
require 'httparty'

class PongBot < SlackRubyBot::Bot
  command 'url' do |client, data, match|
    text = data['text']
    url = text.match(/<([^|>]+)\|?[^>]*>/)[1] rescue nil

    if url
      response = HTTParty.post('http://127.0.0.1:3000/short-url', body: { url: url })
      response_json = JSON.parse(response.body)
      short_id = response_json['shortId']

      client.say(text: "short url : <#{short_id}|#{short_id}>", channel: data.channel)
    else
      client.say(text: 'Invalid URL format', channel: data.channel)
    end
  end
end

PongBot.run
