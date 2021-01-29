class Solve
	def initialize(file)
		@@bots = File.read(file)
			.scan(/(?<=bot\s)\d+/).uniq
			.map{|n| Bot.new(n.to_i)}
		@@outs = File.read(file)
			.scan(/(?<=output\s)\d+/).uniq
			.map{|n| Output.new(n.to_i)}
		@file = file
	end
	def load_cmds
		@cmds = File.readlines(@file).map(&:chomp)
		init_bots
	end
	def init_bots
		@cmds.select{|cmd| cmd =~ /^value/}
			.flat_map{|cmd| [cmd.scan(/\d+/).map(&:to_i)]}
			.each{|val, bot| @@bots.find{|b| b.id == bot}.chips << val}
	end
	def tick
		@@bots.find_all{|b| b.chips.length >= 2}.each do |b|
			next_cmd = @cmds.grep(/\b#{b.id}\sgives/).first
			b.give_chips next_cmd.scan(/(?:bot|output)\s\d+/).drop(1)
			@cmds.delete(next_cmd)
		end
	end
	def part_one(low, high)
		load_cmds
		tick until @@bots
			.find{|b| (b.chips.include? low) && (b.chips.include? high)}
		@@bots
			.find{|b| (b.chips.include? low) && (b.chips.include? high)}.id
	end
	def part_two(outs)
		load_cmds
		out1, out2, out3 = outs.map{|n| @@outs.find{|o| o.id == n}}
		tick until  out1.chips.count >= 1 && 
					out2.chips.count >= 1 && 
					out3.chips.count >= 1
		[out1.chips.first, out2.chips.first, out3.chips.first].reduce(:*)
	end
end
class Bot < Solve
	attr_accessor :id, :chips
	def initialize(id)
		@id = id
		@chips = []
	end
	def give_chips(receivers)
		receivers.zip(@chips.sort) do |r, c|
			targ = r =~ /bot/ ?  
				@@bots.find{|b| b.id == r.gsub(/\b[^0-9]*\b/, "").to_i} :
				@@outs.find{|o| o.id == r.gsub(/\b[^0-9]*\b/, "").to_i}
			targ.chips << c
			@chips.delete(c)
		end
	end
end
class Output < Bot; end

solve = Solve.new("input")
puts "Part one: " + solve.part_one(17, 61).to_s
puts "Part two: " + solve.part_two([0, 1, 2]).to_s
