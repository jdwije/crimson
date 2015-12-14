require 'spec_helper'

describe Risp::Parser do

  before :each do
    @program = '(begin (define r 10) (define pi 3.147) (* pi (* r r)))'
    @interpreter = Risp::Interpreter.new
    @parser = Risp::Parser.new
    @env = Risp::StdEnv.new
  end

  it 'can evaluate a basic program correctly' do
    result = @interpreter.eval(@parser.parse(@program), @env)
    expect(result).to eq(314.7)
    expect(result).to be_kind_of(Float)
  end

end
