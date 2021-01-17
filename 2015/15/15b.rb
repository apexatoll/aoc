class Ingredient
	attr_accessor :cap, :dur, :flv, :tex, :cal
	def initialize(line)
		@name = line.gsub(/(^\w+):.*$/, "\\1")
		@cap, @dur, @flv, @tex, @cal = line.scan(/-?\d+/).map(&:to_i)
	end
end
class Cookie
	def initialize
		@ingredients = File.readlines("input")
			.map{|l| Ingredient.new(l.chomp)}
		caps = @ingredients.map{|i| i.cap}
		durs = @ingredients.map{|i| i.dur}
		flvs = @ingredients.map{|i| i.flv}
		texs = @ingredients.map{|i| i.tex}
		@cals= @ingredients.map{|i| i.cal}
		@stats = {:caps => caps, :durs => durs, :flvs => flvs, :texs => texs}
		get_permutations
	end
	def get_permutations
		@permutations = (0..99).to_a
			.repeated_combination(@ingredients.count).to_a
			.reject{|r| r.reduce(:+) != 100}.to_a
			.map{|p| p.permutation(@ingredients.count).to_a}
			.flatten(1).uniq
	end
	def count_calories
		@valid_perms = @permutations.map do |p|
			p if perm.zip(@cals)
				.map{|cal| cal.reduce(:*)}
				.reduce(:+) == 500
		end.reject{|p| p == nil}
	end
	def gen_scores
		scores = @valid_perms.map do |p|
			@stats.map do |k, v|
				x = p.zip(v)
					.map{|stat| stat.reduce(:*)}
					.reduce(:+)
				x < 0 ? 0 : x
			end.reduce(:*)
		end
		print scores.flatten.max
	end
end
cookie = Cookie.new
cookie.count_calories
cookie.gen_scores
