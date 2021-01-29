class Node
	attr_accessor :name, :next
	def initialize(name)
		@name = name
		@next = File.readlines("example").grep(/^Step\s#{@name}/).flat_map{|l| l.scan(/\b[A-Z]\b/)[1]}
	end
end
class Graph
	def initialize
		@nodes = File.readlines("example").flat_map{|l| l.scan(/\b[A-Z]\b/)}.uniq.map{|n| Node.new(n)}
	end
	def find_root
		root = @nodes
	end
end
Graph.new
