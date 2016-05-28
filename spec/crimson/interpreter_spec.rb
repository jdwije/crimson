require 'spec_helper'

describe Crimson::Interpreter do

  before :each do
    @parser = Crimson::Parser.new
    @env = Crimson::Environment.new
    @interpreter = Crimson::Interpreter.new(@env)
  end

  #######################
  # EXPAND METHOD TESTS #
  #######################

  it 'can expand :quote correctly' do
    prog = <<END
(define x 5)
(define y 2)
(quote (x y))
END

    tree = @parser.parse(prog)
    result = @interpreter.expand(tree)
    expect(result[2]).to eq([:quote, [:x, :y]])

    # validation test
  end

  it 'can expand :if correctly' do
    tree1 = [[:if, [:>, 10, 9], [:display, 10], 10]]
    r1 = @interpreter.expand(tree1)
    expect(r1.first.size).to eq(4)

    # with 3 args
    tree2 = [[:if, [:>, 10, 9], [:display, 10]]]
    r2 = @interpreter.expand(tree2)
    expect(r2.first.size).to eq(4)
    # validation test
  end

  it 'can expand :set correctly' do
    tree = [[:set, :x, [:list, 10, 11, 12, 13, 14, 15]]]
    r = @interpreter.expand(tree)
    expect(r.first.size).to eq(3)
    # validation test
  end

  it 'can expand :define correctly' do
    tree = [[:define, :x, 3]]
    r = @interpreter.expand(tree)
    expect(r.first.size).to eq(3)
    # validation test
  end

  it 'can expand :"define-macro" correctly' do
    badTree = [[:"define-macro", :x, 3]]
    expect{@interpreter.expand(badTree)}.to raise_error(SyntaxError)
  end

  # it 'can expand :begin correctly' do
  #   result = @interpreter.eval(@interpreter.expand(@parser.parse(@program)), @env)
  #   expect(result).to eq(314.7)
  #   expect(result).to be_kind_of(Float)
  # end

  # it 'can expand :lambda correctly' do
  #   result = @interpreter.eval(@interpreter.expand(@parser.parse(@program)), @env)
  #   expect(result).to eq(314.7)
  #   expect(result).to be_kind_of(Float)
  # end

  #####################
  # EVAL METHOD TESTS #
  #####################
end
