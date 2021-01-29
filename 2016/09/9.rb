class Solve
	def initialize
		@input = File.read("example").chomp
		#@input = "X(8x2)(3x3)ABCY"
		#@input = "(27x12)(20x12)(13x14)(7x10)(1x12)A"
		@out = ""
		@r = /\(\d+?x\d+?\)/
	end
	def part_one
		while @input.length != 0
			@input[0] == "(" ?
				@input.match(/\(\d+?x\d+?\)/).to_s
					.tap{|m| @input.sub!(/\(#{m}\)/, "")}
					.scan(/\d+/).map(&:to_i)
					.tap{|n, r| @out << @input[0, n] * r 
						@input.sub!(@input[0, n], "")} :
				@input.split(/(?=\(\d+?x\d+?\))/).first
					.tap{|s| @out << s
						@input.sub!(s, "")}
		end
		@out.length
	end
	def part_two(input = @input)
		chunks = [input.slice!(0...input.index(@r))]
		#chunks = Array.new
		while @r.match? input
			input.match(@r).to_s
				.tap{|m| input.sub!(/\(#{m}\)/, "")}
				.scan(/\d+/).map(&:to_i) 
				.tap{|n, r| chunks << (input[0, n] * r)}
			input.sub!(chunks.last, "")
		end
		chunks << input
		print chunks.join
		#chunks.map{|c| (@r.match? c)? part_two(c) : c}.join
		#input.match(/\(\d+?x\d+?\)/).to_s
			#.tap{|m| input.sub!(/\(#{m}\)/, "")}
			#.scan(/\d+/).map(&:to_i) 
			#.tap{|n, r| $decomp, $post = input[0, n] * r, input[n, -1]}
		#$decomp = part_two($decomp) if (/\(\d+?x\d+?\)/.match? $decomp)
		#$decomp
	end
end
solve = Solve.new
puts solve.part_two
