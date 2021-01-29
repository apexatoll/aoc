class Guard
	attr_accessor :id, :shifts
	def initialize(id)
		@id = id
	end
end
class Solve
	def initialize
		@shifts = File.read("input")
			.split(/(?=\n)/).sort.join
			.split(/(?=Guard)/).map{|g| g.split("\n")}
			.each{|g| g[0] = g[0].gsub(/^.*#(\d+).*$/, "\\1").to_i}
		@guards = @shifts.map{|g| g[0]}.uniq
			.map{|g| Guard.new(g)}
			.each{|g| g.shifts = @shifts.select{|s| s[0] == g.id}}
		#print @guards


		#@guards.sort_by{|g| g.id}.each{|g| print g.inspect; puts}
	end
end
Solve.new
#@shifts = File.read("input").split(/(?=\n)/).sort.join.split(/(?=Guard)/).map{|g| g.split("\n")}.each{|g| g[0] = g[0].gsub(/^.*#(\d+).*$/, "\\1").to_i}
		#@guards = @shifts.map{|g| g[0]}.uniq.map{|g| Guard.new(g)}
		#@guards.each{|g| g.shifts = @shifts.select{|s| s[0] == g.id}}
		#@guards.sort_by{|g| g.id}.each{|g| print g.inspect; puts}
	#end

