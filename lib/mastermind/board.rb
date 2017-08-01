module Mastermind
	class Board
		attr_reader :code
		def initialize(input = nil)
			if input
				@code = input
			else
				@code = code_setter
			end
		end

		def colours
			[ "red", "blue", "green", "orange", "yellow", "purple" ]
		end

		private

		def code_setter
			colours.sample(4)
		end
	end
end