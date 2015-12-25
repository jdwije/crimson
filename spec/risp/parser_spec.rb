require 'spec_helper'

describe Crimson::Parser do

  before :each do
    @parser = Crimson::Parser.new
    @program = '(begin (define r 10) (* pi (* r r)))'
  end

  it 'can tokenize a program string correctly' do
    expectation = ['(', 'begin', '(', 'define', 'r', '10', ')', '(',
                   '*', 'pi','(', '*', 'r', 'r', ')', ')', ')']
    expect(@parser.tokenize(@program)).to eq(expectation)
  end

  it 'can interpret integers correctly' do
    value = '10'
    expect(@parser.atom(value)).to be_kind_of(Integer)
    expect(@parser.atom(value)).to eq(10)
  end

  it 'can interpret floats correctly' do
    value = '5.571'
    expect(@parser.atom(value)).to be_kind_of(Float)
    expect(@parser.atom(value)).to eq(5.571)
  end

  it 'can interpret symbols correctly' do
    value = '+'
    expect(@parser.atom(value)).to be_kind_of(Symbol)
    expect(@parser.atom(value)).to eq(value.to_sym)
  end

  it 'can read from tokens correctly' do
    tokens = @parser.tokenize(@program)
    expectation = [:begin, [:define, :r, 10], [:*, :pi, [:*, :r, :r]]]
    expect(@parser.read_from_tokens(tokens)).to eq(expectation)
  end

end
