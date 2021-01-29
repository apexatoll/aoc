class Item
	attr_accessor :name, :cost, :damage, :armor
	def initialize(line)
		@name = line.gsub(/^([A-Z][a-z]+(\s\+\d+)?).*$/, "\\1")
		@cost, @damage, @armor = 
			line.gsub(@name, "").scan(/\d+/).map(&:to_i)
	end
end
class Game
	def initialize(player, boss)
		@p = player.dup
		@b = boss.dup
		@b_dam = @b[:damage] - @p[:armor] > 0 ? 
				 @b[:damage] - @p[:armor] : 1
		@p_dam = @p[:damage] - @b[:armor] > 0 ?
				 @p[:damage] - @b[:armor] : 1
	end
	def winner
		while 
			@b[:hp] -= @p_dam
			break if @b[:hp] <= 0
			@p[:hp] -= @b_dam
			break if @p[:hp] <= 0
		end
		@b[:hp] <= 0 ? :player : :boss
	end
end
class Solve
	attr_accessor :weapons, :armor, :rings, :boss
	def initialize
		@weapons, @armor, @rings = File.read("shop")
			.split("\n\n")
			.map{|b| b.split("\n").drop(1)
			.map{|l| Item.new(l)}}
		@boss = Hash.new
		@boss[:hp], @boss[:damage], @boss[:armor] = File.readlines("input")
			.map{|l| l.scan(/\d+/).first.to_i}
		@items = [@weapons, @armor, @rings].flatten
	end
	def run
		item_combinations
		calc
		play_games
	end
	def item_combinations
		ring_combos = (0..2).to_a
			.map{|i| @rings.map{|r| r.name}.permutation(i).to_a}
			.flatten(1)
		armor_combos = (0..1).to_a
			.map{|i| @armor.map{|a| a.name}.permutation(i).to_a}
			.flatten(1)
		@combinations = ring_combos
			.product(@weapons.map{|w| w.name})
			.product(armor_combos)
			.map{|c| c.flatten(2)}
	end
	def calc
		@games = @combinations.map do |comb|
			c = comb
				.map{|item| @items.find{|i| i.name == item}.cost}
				.reduce(:+)
			d = comb
				.map{|item| @items.find{|i| i.name == item}.damage}
				.reduce(:+)
			a = comb
				.map{|item| @items.find{|i| i.name == item}.armor}
				.reduce(:+)
			{:hp => 100, :damage => d, :armor => a, :cost => c}
		end
	end
	def play_games
		lost = Array.new
		won  = Array.new
		@games.each do |g|
			winner  = Game.new(g, @boss).winner
			lost << g[:cost] if winner == :boss
			won  << g[:cost] if winner == :player
		end
		puts "Part 1: " + won.min.to_s
		puts "Part 2: " + lost.max.to_s
	end
end
solve = Solve.new
solve.run
