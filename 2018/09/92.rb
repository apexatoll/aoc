#411 players; last marble is worth 71170 points
class Solve
	def initialize
		#@n_players, @last = File.read("input").scan(/\d+/).map(&:to_i)
		@n_players = 9
		@last = 10
		@scores = (1..@n_players).to_a.map{|p| [p, 0]}.to_h
		@marbles = {0=>0}
		@index = 0
		@current = 0
		#puts @current
		#puts @marbles.length
	end 
	def tick
		@current += 1
		#@index += 2
		@index -= @marbles.length if @index > @marbles.length
		@marbles[@current] = @index
		@index = @marbles[@current] + 2
		print @marbles; puts
		puts @index




		#if @current % 23 != 0
			#@marbles.insert(@index, @current)
			#@index = @marbles.index(@current) + 2
		#else
			#player = @current % @n_players
			#player = player > 0 ? player : @n_players
			#@scores[player] += @current + @marbles.delete_at(@index - 9)
			#@index = @index - 7
		#end
	end 
	def play
		#@index = 0
		#tick while @current <= @last
		10.times{tick}
		#hi = @scores.max_by{|p, s| s}[1]
		#puts hi
	end
	def part_two
		#initialize
		#@last *= 100
		play
	end
end
solve = Solve.new
solve.part_two
