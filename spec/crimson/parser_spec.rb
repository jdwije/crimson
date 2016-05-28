require 'spec_helper'

describe Crimson::Parser do

  before :each do
    @parser = Crimson::Parser.new
  end

  it 'can convert tokens to an array correctly' do
    tokens = [:left_bracket, :define, :foo, 5, :right_bracket,
              :left_bracket, :x, 2, :right_bracket]
    result = @parser.sexpr_tokens_to_array tokens
    expect(result).to eq([[:define, :foo, 5], [:x, 2]])
  end

end
