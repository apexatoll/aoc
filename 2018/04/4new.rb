class Guard
	attr_accessor :id, :sleep_times, :time_asleep, :minute, :freq
	def initialize(id)
		@id = id
		@sleep_times = {}
		@time_asleep = 0
	end
	def asleep(times)
		@time_asleep += times.rotate.reduce(:-)
		(times[0]...times[1]).to_a.each do |t|
			@sleep_times.key?(t) ?
				@sleep_times[t] += 1 : @sleep_times[t] = 1
		end
	end
	def find_max_minute
		@minute, @freq = @sleep_times.sort_by{|m, t| -t}
			.map{|m, t| [m, t]}.first
	end
end
class Shifts
	def initialize
		@guards = File.read("input")
			.scan(/(?<=#)\d+/).uniq
			.map{|g| Guard.new(g.to_i)}
		@lines  = File.readlines("input").sort
	end
	def solve
		sleep_times
		puts part_one
		puts part_two
	end
	def sleep_times
		index = 0
		while index < @lines.count
			index += 1 until @lines[index].match?(/asleep/)
			guard = @guards
				.find{|g| g.id == @lines[index - 1]
				.scan(/(?<=#)\d+/).first.to_i}
			while index < @lines.count && @lines[index].match?(/asleep/)
				guard.asleep(parse_times(index))
				index += 2
			end
		end
	end
	def parse_times(index)
		[index, index + 1].map{|i| @lines[i]
			.scan(/(?<=00:)\d\d/).first.to_i}
	end
	def part_one
		id = @guards
			.map{|g| [g.id,  g.time_asleep]}
			.sort_by{|id, time| -time}
			.first.first
		time = @guards
			.find{|g| g.id == id}.sleep_times
			.sort_by{|time, tally| -tally}
			.first.first
		time * id
	end
	def part_two
		@guards.each{|g| g.find_max_minute}
		max_f = @guards.map{|g| g.freq}.reject{|f| f == nil}.max
		guard = @guards.find{|g| g.freq == max_f}
		guard.id * guard.minute
	end
end
Shifts.new.solve
