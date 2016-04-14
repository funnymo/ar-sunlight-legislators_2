require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "0EOq9M5XKEoABBEVJ2XA5lrwY"
  config.consumer_secret     = "aBG0m3nn3TsrgWHseW9fvDrUZvSGaE9lLLk5zv6w8ooalecGbA"
  config.access_token        = "61744177-1Hpg0WkJyNCaOMuOx9MOWgbmail4x8KxqUHFWOiOU"
  config.access_token_secret = "kframDTHLU57YUCdA2EGSludCOZCtBJxIyIiKX7jgvOhr"
end

puts "Please insert congressperson's member id: "
congress_id = gets.chomp.to_i
puts "Congressperson's tweets: "
client.user_timeline(congress_id).take(10).collect do |x|
	puts x.text
end

# def collect_with_max_id(collection=[], max_id=nil, &block)
#   response = yield(max_id)
#   collection += response
#   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
# end

# def client.get_all_tweets(user)
#   collect_with_max_id do |max_id|
#     options = {count: 10, include_rts: true}
#     options[:max_id] = max_id unless max_id.nil?
#     user_timeline(user, options)
#   end
# end