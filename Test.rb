require_relative "MovieData"
class Test
	test = MovieData.new("ml-100k/u1.base")
	test.run_test
	puts test.testdata.mean
	puts test.testdata.stddev
end