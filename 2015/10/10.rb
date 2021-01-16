class Game
	def next_num
		@input = @input
			.gsub(/((.)(?!\2)|((.)\4*))/, "\\1;")
			.split(";")
			.map{|n| [n.length, n[0]]}
			.join
	end
	def run(n)
		@input = "3113322113"
		n.times{next_num}
		@input.length
	end
	def solve
		p1 = run(40)
		p2 = run(50)
		[p1, p2]
	end
end
game = Game.new
puts game.solve
