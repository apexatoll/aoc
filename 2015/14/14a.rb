class Reindeer
	attr_accessor :name, :speed, :travel_time, :rest_time, :period, 
		:n_periods, :distance
	def initialize(line)
		r = /(.*?)\scan.*?(\d+).*?for\s(\d+).*for\s(\d+).*$/
		@name, @speed, @travel_time, @rest_time =
			line.gsub(r, "\\1;\\2;\\3;\\4").split(";")
		@period = [@travel_time, @rest_time].flatten.map(&:to_i).reduce(:+)
		@speed = @speed.to_i
		@travel_time = @travel_time.to_i
		@rest_time = @rest_time.to_i
	end
end
class Solve
	attr_accessor :reindeers, :time
	def initialize
		@reindeers = File.readlines("input").map{|l| Reindeer.new(l.chomp)}
		@time = 2503
		get_distances
	end
	def get_distances
		@reindeers.each do |r|
			r.n_periods = (2503 / r.period).floor
			r.distance = r.n_periods * r.travel_time * r.speed
			r.distance += 2503 % r.period > r.travel_time ? 
				r.travel_time * r.speed :
				2503 % r.period * r.speed
		end
	end
	def get_furthest
		@distances = @reindeers.map{|r| r.distance}.sort
		puts @distances.last
	end
end
solve = Solve.new
solve.get_furthest
