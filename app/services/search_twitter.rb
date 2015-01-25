class SearchTwitter
	def initialize
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV.fetch('CONSUMER_KEY'){""}
			config.consumer_secret     = ENV.fetch('CONSUMER_SECRET'){""}
			config.access_token        = ENV.fetch('ACCESS_TOKEN'){""}
			config.access_token_secret = ENV.fetch('ACCESS_TOKEN_SECRET'){""}
		end
	end
	def searchAll(items)
		result = Array.new
		items.each do |row|
			currentRow = row.drop(1)
			@client.user_timeline(row[0],{:count => 200}).each do |tweet|
				if (currentRow.any? { |word| tweet.text.include?(word)})
					result.push([row[0],tweet,currentRow.join(",")])
				end
			end
		end
		return result
	end
	def searchLatest(items)
		result = Array.new
		items.each do |row|
			currentRow = row.drop(1)
			@client.search("from:"+row[0]).each do |tweet|
				if (currentRow.any? { |word| tweet.text.include?(word)})
					result.push([row[0],tweet,currentRow.join(",")])
				end
			end
		end
		return result
	end

end