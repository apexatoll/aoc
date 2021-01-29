#411 players; last marble is worth 71170 points
class Solve
	def initialize
		@n_players, @last = File.read("input").scan(/\d+/).map(&:to_i)
		@scores = (1..@n_players).to_a.map{|p| [p, 0]}.to_h
		@marbles, @current = [0], 0
	end
	def tick
		@current += 1
		if @current % 23 != 0
			@index -= @marbles.length if @index > @marbles.length
			@marbles.insert(@index, @current)
			@index += 2
		else
			player = @current % @n_players
			player = player > 0 ? player : @n_players
			@scores[player] += @current + @marbles.delete_at(@index - 9)
			@index = @index - 7
		end
	end 
	def play
		@index = 0
		tick while @current <= @last
		hi = @scores.max_by{|p, s| s}[1]
		puts hi
	end
	def part_two
		initialize
		@last *= 100
		play
	end
end
solve = Solve.new
solve.part_two
