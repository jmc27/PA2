#Jonathan Chu
#Assignment 1

#MovieData class

require_relative 'MovieTest'
class MovieData
        attr_accessor :moviedata, :userdata, :testdata
        def initialize(path)
            @moviedata = Hash.new { |hash, key| hash[key] = [0, 0]}
            @userdata = Hash.new { |hash, key| hash[key] = []}
           
            load_data path
        end

        #loads data from a file and sets globals
        def load_data(filename)
            File.open(filename, 'r').each_line do |line|
                    line = line.split '	'

                    @moviedata[line[1].to_sym][0] += 1
                    @moviedata[line[1].to_sym][1] += line[2].to_i

                    @userdata[line[0].to_sym].push([line[1], line[2].to_i])
                        
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
                        puts @moviedata.keys.size
                        return @moviedata.keys.size - position
                else
                        puts "Movie not found"
                        return nil
                end                 
        end
        
        def popularitylist
                #returns a list of movie id's sorted and ordered by decreasing popularity
                movie_list = @moviedata.keys
                movie_list.sort_by{ |key| [@moviedata[key][1], @moviedata[key][0]] }.reverse
        end

        #similarity between users is determined by comparing the difference in ratings
        #of movies that both users rated
        def similarity(user1, user2)
                if @userdata.has_key? user1.to_s.to_sym and @userdata.has_key? user2.to_s.to_sym

                        sim_rating = 0
                        user1ratings = @userdata[user1.to_s.to_sym]
                        user2ratings = @userdata[user2.to_s.to_sym]
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
                userlist = @userdata.keys
                userlist.sort_by{ |id| [similarity(u, id)] }.reverse.drop(1)
        end
        # returns the rating that user u gave movie m in the training set (u.data), and 0 if user u did not rate movie m
        def rating u, m
        	user_ratings = @userdata[u.to_s.to_sym]
        	flag = 0
        	user_ratings.each do |id, rating|
        		if m.to_s == id
        			#puts "User " + u.to_s + " rated movie " + id + " with a " + rating.to_s
        			flag = 1
        			return rating
        		end
        	end
        	if flag == 0
        		return 0
        	end
        end
        #returns a floating point number between 1.0 and 5.0 as an estimate of what user u would rate movie m
        #my prediction algorithm checks if you've already rated the movie and if you have not it predicts that you
        #will rate the movie m with the average of all the movie ratings you've given
        def predict u, m
        	if rating(u, m) == 0
        		#puts avg_rating 
        		return avg_rating u
        	else
        		#puts rating u, m
        		return rating u, m
        	end
        end
        #returns the average of all the ratings user u has given
        def avg_rating u
        	user_ratings = @userdata[u.to_s.to_sym]
        	avg = 0
        	user_ratings.each do |id, rating|
        		avg += rating
        	end
        	avg = avg / user_ratings.size.to_f
        	return avg
        end

        #returns an array of the movies user u has watched and rated
        def movies u
        	user_ratings = @userdata[u.to_s.to_sym]
        	size = user_ratings.size
        	movies = []
        	user_ratings.each do |id, rating|
        		movies.push(id)
        	end

        	#puts size
        	#puts movies.size
        	return movies
        end
        #returns an array of users that have seen movie m
        def viewers m
        	users = @userdata.keys
        	movie_viewers = []
        	users.each do |user|
        		if rating(user, m) != 0
        			movie_viewers.push(user)
        		end

        	end
        	return movie_viewers
        end
        #run_test method without k parameter so it only works
        # on the full file test and training files
        def run_test 
            
            test_table = make_test_table("ml-100k/u1.test")
            @testdata = MovieTest.new(test_table)
        end
        #make table of results for run_test
        def make_test_table path
            testdata = MovieData.new(path)
            users = testdata.userdata.keys
            test_table = []
            users.each do |key|
                testdata.userdata[key.to_s.to_sym].each do |id, actualrating|
                    test_table.push([key, id, actualrating, predict(key, id)])
                end
            end
            return test_table
        end
end

