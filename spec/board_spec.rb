require "spec_helper"

module Mastermind
	RSpec.describe Board do
		
		context "#initialize" do
			it "sets the board with a code equal to 4 colours at random" do
				board = Board.new
				expect(board.code.size).to eq(4)
			end

			it "sets the code to a given code" do
				board = Board.new(["red","green","blue","orange"])
				expect(board.code).to eq ["red","green","blue","orange"]
			end

		end

	end
end