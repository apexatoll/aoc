class Solve
	def initialize
		#@input = File.read("input").chomp
		@input = File.read("example").chomp
		@r = /\((\d+)?x\d+?\)\w/
	end
	def part_two
		#@r = @input.scan(/(?=(\(\d+?)x\d+?\)(.){\1})/)
		print @r
		#@input.scan(@r).each{|chunk| get_chunk chunk}
		#print cmds
	end
	def get_chunk(chunk)

	end
end
solve = Solve.new
puts solve.part_two
