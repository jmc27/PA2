require_relative "MovieData"
class Test
	start = Time.now
	test = MovieData.new("ml-100k/u1.base")
	test.run_test
	puts test.testdata.mean
	puts test.testdata.stddev
	puts test.testdata.rmsd
	finish = Time.now
	time = finish - start
	puts "Time: " + time.to_s
end