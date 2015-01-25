class SearchController < ApplicationController
	def index
		render 'show', :layout => 'application', :locals => { :tweets => []}
	end
	def search
		rows = JSON.parse(params[:rows])
		twitterClass = SearchTwitter.new()
		tweets = Array.new
		if(params[:search] == 'all')
			tweets = twitterClass.searchAll(rows)
		else
			tweets = twitterClass.searchLatest(rows);
		end
		tweets.sort! {|a,b| b[1].created_at <=> a[1].created_at}
		render :partial => '/search/api', :locals => { :tweets => tweets }

	end
end
