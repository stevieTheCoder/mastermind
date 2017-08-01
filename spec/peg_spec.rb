require "spec_helper"

module Mastermind
	RSpec.describe Peg do 
		
		context "#initialize" do 
			it "raises an error if a colour isn't given" do
				expect { Peg.new() }.to raise_error(ArgumentError)
			end
		end

		context "#colour" do
			it "returns the colour" do
				peg = Peg.new("red")
				expect(peg.colour).to eq "red"
			end
		end

	end
end