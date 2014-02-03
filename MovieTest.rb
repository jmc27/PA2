
class MovieTest
	attr_accessor :meanerror, :moviedata, :stddev, :avg
	#initialize training data set 
	def initialize data
		@moviedata = data
		@avg = avg_rating
		@meanerror = mean
		@stddev = stddev
	end
	#returns the average predication error 
	def mean
		error = 0
		@moviedata.each do |line|
			error += (line[2] - line[3]).abs
			
			
		end
		return error / @moviedata.size.to_f
	end
	#returns the standard deviation of the error
	def stddev
		variance = 0
		@moviedata.each do |line|
			variance += (line[2] - @avg) ** 2
		end
		return Math.sqrt(variance / @moviedata.size.to_f)
	end
	#returns the mean, average of all ratings
	def avg_rating
		avg = 0
		@moviedata.each do |line|
			avg += line[2]
		end
		return avg / @moviedata.size.to_f
	end
	#returns the root mean square error of the prediction
	def rms actual, prediction
		return Math.sqrt((actual - prediction) ** 2)
	end
	#returns an array of the predictions in the form [u,m,r,p]. 
	#You can also generate other types of error measures if you want, 
	#but we will rely mostly on the root mean square error.
	def to_a 
		a = []
		@moviedata.each do |line|
			a.push([line[0], line[1], rms(line[2], line[3]), line[3]])
		end
		return a
	end
end
