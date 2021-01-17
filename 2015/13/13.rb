class Person
	attr_accessor :name, :relations
	def initialize(name)
		@name = name
		@relations = Hash.new
	end
end
class Solve
	def initialize
		lines = File.readlines("input").map(&:chomp)
		@people = lines.map{|l| l.scan(/[A-Z][a-z]+/)}
			.flatten.uniq
			.map{|n| Person.new(n)}
		lines.each do |l|
			target, pol, units, other = 
				l.gsub(/^(\w+)\swould\s(gain|lose)\s(\d+).*([A-Z][a-z]+)\./, "\\1;\\2;\\3;\\4").split(";")
			units = units.to_i
			units *= -1 if pol == "lose"
			@people.find{|p| p.name == target}
				.relations[other.to_sym] = units
		end
	end
	def run(part = 1)
		add_self if part == 2
		puts calculate
	end
	def add_self
		me = Person.new("Me")
		@people.map{|p| p.name}.each{|name| me.relations[name.to_sym] = 0}
		@people.map{|p| p.relations[:Me] = 0}
		@people << me
	end
	def calculate
		@people.map{|p| p.name}.permutation(@people.count).to_a.map do |l|
			@people.map.with_index do |_, i|
				person = @people.find{|p| p.name == l[i]}
				left = i + 1 >= @people.count ? 
					l[0] : l[i+1]
				right = l[i - 1]
				[left, right].map{|p| person.relations[p.to_sym]}.reduce(:+)
			end.reduce(:+)
		end.max
	end
end
solve = Solve.new
solve.run
