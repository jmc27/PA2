class MovieTest
	attr_accessor :filename, :stats
	def initialize path, k
		@filename = path
		load_data k
	end

	def load_data k
		File.open(@filename, 'r') do |file| 
			line_itr = file.each k.times do
				line = line_itr.next.split '	'
				puts line
			end
		end
	end
end