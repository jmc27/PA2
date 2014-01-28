class MovieTest
	attr_accessor :filename, :stats, :moviedata, :testdata
	def initialize path, k
		@filename = path
		@moviedata = MovieData.new('ml-100k')
		@testdata = []
		load_data
	end

	def load_data k
		
	end

	def load_data
		File.open(@filename, 'r').each_line do |line|
			line = line.split '	'
		end
	end
	#returns the average predication error 
	def mean

	end
	#returns the standard deviation of the error
	def stddev
		
	end
	#returns the root mean square error of the prediction
	def rms
		
	end
	#returns an array of the predictions in the form [u,m,r,p]. 
	#You can also generate other types of error measures if you want, 
	#but we will rely mostly on the root mean square error.
	def to_a 
		
	end
end