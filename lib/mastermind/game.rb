module Mastermind
	class Game
		attr_accessor :player_name, :board, :counter, :guesses
		def initialize(player_name, board = Board.new,counter = 0)
			@player_name = player_name
			@board = board
			@counter = counter
			@guesses = guesses
		end

		def play
			puts "#{player_name} you have 12 attempts to guess a code consisting of 4 of the following: #{board.colours}"
			while true
				puts solicit_move
				@guesses = user_input_as_array
				puts feedback_message_exact_matches
				puts feedback_message_colours_matched
				if game_over
					puts game_over_message
					return false
				end
			end
		end

		def solicit_move
			"#{player_name} make your guess, please enter 4 colours seperated by a comma, you have #{12 - counter} guesses remaining"
		end

		def user_input_as_array(inputs = gets.chomp)
			@counter += 1
			split_inputs = inputs.split(/\s*,\s*/)
			return split_inputs
		end

		def test_for_exact_code_matches
			guesses.zip(board.code).map { |x,y| x == y }
		end

		def test_for_colour_matches_in_code
			guesses.map { |guess| board.code.include? guess }
		end

		def feedback_message_colours_matched
			number_matched = test_for_colour_matches_in_code.count(true)
			"you have #{number_matched} colours correct"
		end

		def feedback_message_exact_matches
			number_matched = test_for_exact_code_matches.count(true)
			"you have #{number_matched} exact matches"
		end

		def game_over
			return :winner if winner?
			return :lose if lose?
			false
		end

		def game_over_message
			return "#{player_name} you beat the code!" if game_over == :winner
			return "You have run out of guesses and have not been successful in guessing the code!" if game_over == :lose
		end

		def winner?
			return true if guesses == board.code
			false
		end

		def lose?
			return true if counter == 12
			false
		end

	end
end
