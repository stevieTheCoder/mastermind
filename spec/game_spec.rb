require  "spec_helper"

module Mastermind
	RSpec.describe Game do

		context "#initialize" do
			it "can be initialized with a player name and that name can be accessed" do
				game = Game.new("steve")
				expect(game.player_name).to eq "steve"
			end

			it "initializes the game with a counter of '0'" do
				game = Game.new("steve")
				expect(game.counter).to eq 0
			end
		end

		context "#solicit_move" do
			it "asks the player for input" do
				game = Game.new("steve")
				expected = "steve make your guess, please enter 4 colours seperated by a comma, you have 12 guesses remaining"
				expect(game.solicit_move).to eq expected
			end
		end

		context "#user_input_as_array" do
			it "collects the user input and returns an array" do
				user_input = "red, blue, green, orange"
				expected = ["red", "blue", "green", "orange"]
				game = Game.new("steve")
				expect(game.user_input_as_array(user_input)).to eq expected
			end

			it "increments the move counter by 1" do
				user_input = "red, blue, green, orange"
				game = Game.new("steve")
				game.user_input_as_array(user_input)
				expect(game.counter).to eq 1
			end
		end

		context "#winner?" do
			it "returns true if the code equals user input" do
				colour_test = ["red", "blue", "green", "orange"]
				game = Game.new("steve", Board.new(colour_test))
				allow(game).to receive(:guesses) { colour_test }
				expect(game.winner?).to be true
			end

			it "returns false if the code does not equal user input" do
				colour_test = ["red", "blue", "green", "orange"]
				code_test = ["red", "blue", "green", "purple"]
				game = Game.new("steve", Board.new(code_test))
				allow(game).to receive(:guesses) { colour_test }
				expect(game.winner?).to be false
			end
		end

		context "#lose?" do
			it "returns true if the counter reaches 12" do
				game = Game.new("steve")
				allow(game).to receive(:counter) { 12 }
				expect(game.lose?).to be true
			end

			it "returns false if the counter is less than 12" do
				game = Game.new("steve")
				allow(game).to receive(:counter) { 1 }
				expect(game.lose?).to be false
			end
		end

		context "#game_over" do
			it "returns :winner if winner? is true" do
				colour_test = ["red", "blue", "green", "orange"]
				game = Game.new("steve")
				allow(game).to receive(:winner?) {true}
				expect(game.game_over).to eq :winner
			end

			it "returns :lose if winner? is false and lose? is true" do
				game = Game.new("steve")
				colour_test = ["red", "blue", "green", "orange"]
				allow(game).to receive(:winner?) {false}
				allow(game).to receive(:lose?) {true}
				expect(game.game_over).to eq :lose
			end
		end

		context "#game_over_message" do
			it "returns 'player_name' you beat the code! if codes match" do
				game = Game.new("steve")
				allow(game).to receive(:game_over) { :winner }
				expect(game.game_over_message).to eq "steve you beat the code!"
			end

			it "returns losing message if the counter reaches 12 without winning" do
				expected = "You have run out of guesses and have not been successful in guessing the code!"
				game = Game.new("steve")
				allow(game).to receive(:game_over) { :lose } 
				expect(game.game_over_message).to eq expected
			end
		end

		context "#test_for_exact_code_matches" do
			it "returns TRUE if the guess is an exact match to the code" do
				guess_test = ["red", "blue", "green", "orange"]
				code_test = ["red", "purple", "green", "orange"]
				expected = [TRUE, FALSE, TRUE, TRUE]
				game = Game.new("steve",board = Board.new(code_test))
				allow(game).to receive(:guesses) { guess_test }
				expect(game.test_for_exact_code_matches).to eq expected
			end
		end

		context "#test_for_colour_matches_in_code" do
			it "returns TRUE if the guess colour exists anywhere in the code" do
				code_test = ["red", "blue", "green", "orange"]
				guess_test = ["purple", "red", "blue", "black"]
				expected = [FALSE, TRUE, TRUE, FALSE]
				game = Game.new("steve",board = Board.new(code_test))
				allow(game).to receive(:guesses) { guess_test }
				expect(game.test_for_colour_matches_in_code).to eq expected
			end
		end

		context "#feedback_message_colours_matched" do
			it "confirms the number of correct colours if there are no direct matches" do
				code_test = ["red", "blue", "green", "orange"]
				guess_test = ["blue", "green", "orange", "red"]
				expected = "you have 4 colours correct"
				game = Game.new("steve",board = Board.new(code_test))
				allow(game).to receive(:guesses) { guess_test }
				expect(game.feedback_message_colours_matched).to eq expected
			end
		end

		context "#feedback_message_exact_matches" do
			it "confirms the number of correct colours if there are no direct matches" do
				code_test = ["red", "blue", "green", "orange"]
				guess_test = ["red", "blue", "orange", "green"]
				expected = "you have 2 exact matches"
				game = Game.new("steve",board = Board.new(code_test))
				allow(game).to receive(:guesses) { guess_test }
				expect(game.feedback_message_exact_matches).to eq expected
			end
		end	

	end
end