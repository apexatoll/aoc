class Bot
	attr_accessor :id, :chips
	def initialize(id)
		@id = id
		@chips = Array.new
	end
	def get_chip(chip)
		@chips << chip
		check_chips
	end
	def give_chip(chip)
		@chips.delete(chip)
	end
end
class Bots
	attr_accessor :bots, :lines, :target_bot
	def initialize
		@bots = Array.new
		allBots = Array.new
		@lines = File.readlines("input").map{|l| l.chomp}
		@lines.each do |l|
			if l =~ /^value/
				bot = l.gsub(/^.*bot ([0-9]*)[^0-9]*$/, "\\1").to_i
				allBots << bot
			elsif l =~ /^(bot.*){3}/
				bots = l.gsub(/( gives low to | and high to )/, ";").split(";").map{|b| b.gsub(/bot /, "").to_i}
				allBots << bots
			end
		end
		allBots.flatten.sort.uniq.each do |bot|
			@bots << Bot.new(bot)
		end
	end
	def run
		start
		tick
	end
	def start
		@lines.grep(/^value/).each do |l|
			num = l.gsub(/^.*bot ([0-9]*).*$/, "\\1").to_i
			chip = l.gsub(/^value ([0-9]*).*$/, "\\1").to_i
			@bots.find{|b| b.id == num}.chips << chip
		end
	end
	def tick
		@bots.find_all{|b| b.chips.count == 2}.each do |b|
			low = b.chips.sort[0]
			high = b.chips.sort[1]
			cmd = @lines.grep(/^bot #{b.id}/)
			dest = parse_bot2bot(cmd.to_s)
			print dest
		end
	end
	def parse_bot2bot(line)
		low = line.gsub(/^.*low to bot ([0-9]*).*$/, "\\1").to_i
		hi = line.gsub(/^.*high to bot ([0-9]*).*$/, "\\1").to_i
		return {:low => low, :hi => hi}
	end
end
bots = Bots.new
bots.run
