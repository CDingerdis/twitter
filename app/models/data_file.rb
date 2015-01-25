class DataFile < ActiveRecord::Base
	def save(file)
		@file = file['dataFile']
		return plain:@file.to_yaml
end
