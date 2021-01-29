class Solve
	def initialize
		@nums = (0..255).to_a
		@cmds = File.read("input").split(",").map(&:to_i)
		@nums = (0..4).to_a
		@cmds = [3, 4, 1, 5]
		@cpos = 0
		@skip = 0
	end
	def run
		@cmds.each do |c|
			slice = @nums.slice!(@cpos, c).reverse
			@nums = @nums.insert(@cpos, slice).flatten!
			@cpos += c 
			@cpos -= @nums.count if @cpos >= @nums.count - 1
			puts @cpos
			@cpos += @skip
			@skip += 1
			print @nums
			puts
		end
	end
end
Solve.new.run
