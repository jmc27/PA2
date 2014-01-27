#Jonathan Chu
#Assignment 1

#MovieData class
class MovieData
	attr_accessor :filename, :moviedata, :userdata
	def initialize
		@moviedata = Movie.new
		@userdata = User.new
	end
	def initlialize path 
		initialize
	end
	def initialize path training_set
		initialize
		
	end
	#loads data from a file and sets globals
	def load_data(filename)
		@filename = filename
		numlines = 0;
		File.open(filename, 'r').each_line do |line|
			
			numlines += 1

			@moviedata.load_line line
			@userdata.load_line line
		end
		#puts numlines
	end
	#popularity is ranked by the movie id's position in the popularity list
	#because high number means higher popularity, popularity must be represented
	#by the size of the list minus the position
	def popularity(movieid)
		movielist = popularitylist
		position = movielist.index movieid.to_s.to_sym
		if position
			puts @moviedata.movies.keys.size 
			return @moviedata.movies.keys.size - position
		else
			puts "Movie not found"
			return nil
		end 		
	end
	
	def popularitylist
		#returns a list of movie id's sorted and ordered by decreasing popularity
		movie_list = @moviedata.keys
		movie_list.sort_by{ |key| [@moviedata[key][1], @moviedata[key][0]] }
	end

	#similarity between users is determined by comparing the difference in ratings
	#of movies that both users rated
	def similarity(user1, user2)
		if @userdata.has_key? user1.to_s.to_sym and @userdata.has_key? user2.to_s.to_sym

			sim_rating = 0
			user1ratings = @userdata.users[user1.to_s.to_sym]
			user2ratings = @userdata.users[user2.to_s.to_sym]
			user2ids = []
			user2ratings.each{ |id, rating| user2ids.push id }
			user1ratings.each{ |id, rating| sim_rating += 5 - (rating - user2ratings[user2ids.index id][1]).abs if user2ids.include? id}
					return sim_rating
		else
			puts "User not found"
			return nil
		end
	end
	#return a list of users most similar to u
	def most_similar(u)
		userlist = @userdata.users.keys
		userlist.sort_by{ |id| [similarity(u, id)] }.reverse.drop(1)
	end
end


#test
data = MovieData.new()
data.init
data.load_data("u.data")
#puts data.popularitylist.first(50)
#puts data.popularity(1562)
#puts data.most_similar(100).first(5)
puts data.similarity(100, 13)


