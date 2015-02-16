class Player
attr_accessor :name, :preference

	def initialize(name, preference = nil)
		@name = name
		@preference = preference
	end
end