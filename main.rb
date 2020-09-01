# header

require "twitter"
require 'dotenv'
Dotenv.load
# SSL証明書
ENV["SSL_CERT_FILE"] = File.expand_path("./cacert.pem")

# bundlerでgem入れてるから、bundle exec ruby main.rbじゃないと動かないよ〜

# body

# アカウント設定
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end
# stream_client = Twitter::Streaming::Client.new do |config|
#   config.consumer_key        = ENV["CONSUMER_KEY"]
#   config.consumer_secret     = ENV["CONSUMER_SECRET"]
#   config.access_token        = ENV["ACCESS_TOKEN"]
#   config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
# end

# tweet
client.update("test")

# いいね
# client.favorite(tweet.id)

# tweetを検索
# client.search(search_keyword, exclude: "retweets", result_type: "recent").take(20).each do |row_tweet|
#   tweet += row_tweet.text + "\n"
# end
# puts tweet