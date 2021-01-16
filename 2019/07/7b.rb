require "./intcode.rb"
class Amplifiers
	attr_accessor :perms, :amps
	def get_permutations(min, max)
		@perms = (min..max).to_a.permutation(5).to_a.map{|p| p}
	end
	def set_amps(permutation)
		@amps = Array.new
		permutation.each do |phase|
			amp = Intcode.new
			amp.phase = phase
			@amps << amp
		end
	end
	def get_max
		@signals = Array.new
		@perms.each do |p|
			set_amps(p)
			@signal = 0
			while true
				complete = false
				@amps.each do |amp|
					amp.input = @signal
					@signal = amp.run
					if amp.complete == true
						complete = true
						@signals << @signal
						break
					end
				end
				break if complete == true
			end
		end
		#print @signals.sort.last
		print @signals
	end
end
amps = Amplifiers.new
amps.get_permutations(5, 9)
amps.get_max
