require 'spec_helper'

describe Crimson::Parser do

  before :each do
    @program = '(begin (define r 10) (define pi 3.147) (* pi (* r r)))'
    @interpreter = Crimson::Interpreter.new
    @parser = Crimson::Parser.new
    @env = Crimson::Environment.new
  end

  it 'can evaluate a basic program correctly' do
    result = @interpreter.eval(@parser.parse(@program), @env)
    expect(result).to eq(314.7)
    expect(result).to be_kind_of(Float)
  end

end
