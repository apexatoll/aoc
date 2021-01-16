require "./intcode.rb"
class Amplifiers
	attr_accessor :perms
	def get_permutations
		@perms = (0..4).to_a.permutation(5).to_a.map{|p| p}
	end
	def get_max
		@signals = Array.new
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
		print @signals.sort.last
	end
end
amps = Amplifiers.new
amps.get_permutations
amps.get_max
