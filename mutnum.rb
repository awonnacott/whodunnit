class Mutnum
	attr_reader :value
	def initialize(number)
		raise TypeError, "Mutnum created on a non-numeric value" unless number.is_a? Numeric
		@value = number
	end
	def ==(other)
		if other.is_a? Mutnum
			other.value == @value
		else
			@value == other
		end
	end
	def set(newval)
		@value = newval
	end
	def to_i
		@value
	end
	def to_s
		@value.to_s
	end
	def +(other)
		if other.is_a? Numeric
			@value + other
		elsif other.is_a? Mutnum
			Mutnum.new(@value + other.value)
		end
	end
	def coerce(other)
		if other.is_a? Numeric
			[other, @value]
		else
			super
		end
	end
end