class Wire
	attr_accessor :name, :value
end
class Solve
	attr_accessor :cmds
	def initialize
		@cmds = File.readlines("example").map(&:chomp)
	end
end
solve = Solve.new
