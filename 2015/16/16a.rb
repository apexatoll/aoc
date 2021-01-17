class Sue
	attr_accessor :num, :compounds, :valid
	def initialize(line)
		@num = line.gsub(/^Sue\s(\d+).*$/, "\\1")
		@valid = true
		@compounds = line.gsub(/^.*?:\s/, "").split(", ")
			.map{|s| s.split(": ")}
			.map{|k, v| [k.to_sym, v.to_i]}.to_h
	end
end
class Solve
	attr_accessor :sues, :criteria
	def initialize
		@sues = File.readlines("input").map{|l| Sue.new(l.chomp)}
		@criteria = File.readlines("criteria")
			.map{|l| l.chomp.split(": ")}
			.map{|k, v| [k.to_sym, v.to_i]}.to_h
	end
	def find_sue
		nums = @sues.map{|s| s.num}
		@criteria.each do |k, v|
			@sues.each do |s|
				nums.delete(s.num) if !s.compounds[k].nil? && 
					s.compounds[k] != v
			end
		end
		nums.first
	end
end
solve = Solve.new
puts solve.find_sue
