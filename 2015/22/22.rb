class Spell
	class Missile
		def cast
			$boss.hp -= 4 end end
	class Drain
		def cast
			$boss.hp -= 2
			$hero.hp += 2 end end
	class Shield
		attr_reader :timer
		def initialize
			@timer = 6 end
		def cast
			$fx << Effect.new(self) end
		def apply
			$hero.armor = 7 end end
	class Poison
		attr_reader :timer
		def initialize
			@timer = 6 end
		def cast
			$fx << Effect.new(self) end
		def apply
			$boss.hp -= 3 end end
	class Recharge
		attr_reader :timer
		def initialize
			@timer = 5 end
		def cast
			$fx << Effect.new(self) end
		def apply
			$hero.mana += 101 end end
end
class Effect
	attr_reader :name, :timer
	def initialize(spell)
		@name = spell.class.to_s.gsub(/^.*::/, "").to_sym
		@timer = spell.timer
		@spell = spell
	end
	def tick
		@spell.apply
		@timer -= 1
	end
end
class Player
	class Hero
		attr_accessor :hp, :mana, :armor, :spells, :spell, :spent
		def initialize
			@hp, @mana, @armor, @spent = 50, 500, 0, 0
			@spells = {
				:Missile => 53, 
				:Drain => 73, 
				:Shield => 113, 
				:Poison => 173, 
				:Recharge => 229}
		end
		def turn
			next_spell = choose_spell
			cast(next_spell)
		end
		def choose_spell
			(@spells.reject{|spell, cost| cost > @mana}.keys - 
				$fx.map{|e| e.name}).flatten
				.shuffle
				.first
		end
		def cast(spell_name)
			@mana  -= @spells[spell_name]
			@spent += @spells[spell_name]
			Spell.const_get(spell_name.to_s).new.cast
		end
	end
	class Boss
		attr_accessor :hp, :damage
		def initialize
			@hp, @damage = 51, 9
		end
		def turn
			$hero.hp -= @damage - $hero.armor
		end
	end
end
class Game
	attr_reader :winner, :spent
	def initialize
		$hero = Player::Hero.new
		$boss = Player::Boss.new
		$fx = []
	end
	def play(mode)
		until $hero.hp <= 0 || $boss.hp <= 0 || $hero.mana < 53
			$hero.hp -= 1 if mode == :hard
			break if $hero.hp <= 0
			effects
			$hero.turn
			effects
			break if $boss.hp <= 0
			$boss.turn
		end
		@winner = $boss.hp <= 0 ? :Hero : :Boss
		@spent = $hero.spent
	end
	def effects
		$fx.map{|e| e.tick}
		$fx = $fx.reject{|e| e.timer == 0}
		$hero.armor = 0 unless ($fx.map{|e| e.name}.any? :Shield)
	end
end
class Solve
	def play_games(mode)
		@wins = []
		8000.times do
			game = Game.new
			game.play(mode)
			@wins << game.spent if game.winner == :Hero 
		end
		@wins.min
	end
	def part_one
		play_games(:easy)
	end
	def part_two
		play_games(:hard)
	end
end
solve = Solve.new
puts solve.part_one
puts solve.part_two
