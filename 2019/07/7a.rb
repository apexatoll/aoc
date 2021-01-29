require_relative "intcode"
class Amplifiers
	#attr_accessor :perms
	def get_permutations
		@perms = (0..4).to_a.permutation(5).to_a
	end
	def get_max
		@signals = []
		@perms.each do |p|
			@signal = 0
			p.each do |phase|
				comp = Intcode.new
				comp.input = @signal
				comp.phase = phase
				@signal = comp.run
				@signals << @signal
			end
		end
		@signals.max
	end
end
amps = Amplifiers.new
amps.get_permutations
puts amps.get_max
