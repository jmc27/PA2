class User
	attr_accessor :users
	def initialize 
		@users = Hash.new { |hash, key| hash[key] = []}
	end
	#loads a line and splits it and pushes it to the hash of of users
	def load_line line
		line = line.split '	'
		@users[line[0].to_sym].push([line[1], line[2].to_i])
	end
end