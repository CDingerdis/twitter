class UploadController < ApplicationController
	require 'csv'
	def create
		dir = 'public/uploads/'
		# binding.pry
		file = upload_params[:dataFile]
		name = file.original_filename
		path = File.join(dir, name)
		rows = Array.new
		CSV.open(path, :row_sep => "\r\r\n") do |csv|
			csv.each do |row|
				row = row[0].split(";")
				if !row.empty?
			 		rows.push(row)
				end
			end
		end
		rows = rows.drop(1)
		redirect_to :controller => 'search', :action => 'search',:search => upload_params[:search], :rows => rows.to_json
	end
	private
	def upload_params
		 params.require(:upload).permit(:dataFile,:search)
	end
end
