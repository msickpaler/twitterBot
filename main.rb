# header

require "twitter"
require "dotenv"
require "byebug"
require "net/http"
Dotenv.load
# SSL証明書
ENV["SSL_CERT_FILE"] = File.expand_path("./cacert.pem")

# bundlerでgem入れてるから、bundle exec ruby main.rbじゃないと動かないよ〜

# body

# アカウント設定
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end
# stream_client = Twitter::Streaming::Client.new do |config|
#   config.consumer_key        = ENV["CONSUMER_KEY"]
#   config.consumer_secret     = ENV["CONSUMER_SECRET"]
#   config.access_token        = ENV["ACCESS_TOKEN"]
#   config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
# end

# tweet
# client.update("test")
# いいね
# client.favorite(tweet.id)
# RT
# client.retweet(tweet)
# フォロー
# client.follow(tweet.user)
# tweetを検索
# client.search("keyword", exclude: "retweets", result_type: "recent").take(1)
# フォロワーの数
# tweet.user.followers_count

search_keyword_jp = "フォロー　リツイート"
search_keyword_en = "follow retweet"

client.search(search_keyword_jp, exclude: "retweets", result_type: "recent").take(100).each do |tweet|
  if tweet.user.followers_count > 1000
    client.retweet(tweet)
    client.favorite(tweet)
    client.follow(tweet.user)
    a = tweet.text
    if a.include?("#")
      sharp = a.index("#")
      space = a.index(" ", sharp)
      n = a.index("\n", sharp)
      hashtag = space > n ? a[sharp..n - 1] : a[sharp..space - 1]
      client.update("人生をもう少し豊かにしたいなあ\n#{hashtag}")
    end
  end
end
client.search(search_keyword_en, exclude: "retweets", result_type: "recent").take(100).each do |tweet|
  if tweet.user.followers_count > 1000
    client.retweet(tweet)
    client.favorite(tweet)
    client.follow(tweet.user)
    a = tweet.text
    if a.include?("#")
      sharp = a.index("#")
      space = a.index(" ", sharp)
      n = a.index("\n", sharp)
      hashtag = space > n ? a[sharp..n - 1] : a[sharp..space - 1]
      client.update("i wanna enrich my life a little more.\n#{hashtag}")
    end
  end
end
