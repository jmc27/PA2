require_relative "MovieData"
class Test
	test = MovieData.new("ml-100k/u1.base")
	test.run_test
	puts test.testdata.meanerror
	puts test.testdata.stddev
	puts test.testdata.rmsd
end