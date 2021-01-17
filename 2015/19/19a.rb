class Replacement
	attr_accessor :input, :output, :mol
	def initialize(line, mol)
		@input, @output = line.split(" => ")
		@mol = mol
	end
	def apply
		@n = @mol.scan(/#{@input}/).length
		(0..@n - 1).to_a.map do |i|
			r = /(((^|.*?)#{@input}.*?){#{i}})#{@input}/
			@mol.sub(r, "\\1" + @output)
		end
	end
end
class Solve
	def initialize(file)
		reps, @mol = File.read(file).split("\n\n")
		@reps = reps.each_line.map{|l| Replacement.new(l.chomp, @mol.chomp)}
	end
	def get_distinct
		print @reps.map{|r| r.apply}.flatten.uniq.count
	end
end
solve = Solve.new("input")
solve.get_distinct
