class Reindeer
	attr_accessor :name, :distance, :points
	def initialize(line)
		@points, @distance = 0, 0
		@name = line.gsub(/^(.*?)\s.*$/, "\\1")
		@speed, @travel_time, @rest_time = line.scan(/\d+/).map(&:to_i)
		@period = @travel_time + @rest_time
	end
	def tick(time)
		time = time >= @period ? 
			time % @period : time
		@state = time <= @travel_time && time > 0 ? 
			:flying : :resting
		@distance += @speed if @state == :flying
	end
end
class Solve
	def initialize
		@reindeers = File.readlines("input").map{|l| Reindeer.new(l.chomp)}
		@time  = 1
		@total = 2503
	end
	def run
		while @time <= @total
			@reindeers.each{|r| r.tick(@time)}
			award_point
			@time += 1
		end
		get_winner
	end
	def award_point
		@furthest = @reindeers.map{|r| r.distance}.max
		@reindeers.find_all{|r| r.distance == @furthest}
			.each{|r| r.points += 1}
	end
	def get_winner
		winner, points = @reindeers.map{|r| [r.name, r.points]}
			.max_by{|n, p| p}
	end
end
solve = Solve.new
puts solve.run
