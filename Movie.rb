class Movie
	def initialize
		attr_accessor :movies
		@movies = Hash.new { |hash, key| hash[key] = [0, 0]}
	end
	#takes a line as a parameter and splits it and inputs it into the hash
	def load_line line 
		line = line.split '	'
		@moviedata[line[1].to_sym][0] += 1
		@moviedata[line[1].to_sym][1] += line[2].to_i
	end
end