require 'spec_helper'

describe Crimson::StdEnv do

  before :each do
    @std_env = Crimson::StdEnv.new
  end

  it 'can handle operation correctly' do
    expect(@std_env[:+].call(1, 2)).to eq(3)
    expect(@std_env[:-].call(2, 1)).to eq(1)
    expect(@std_env[:*].call(1, 2)).to eq(2)
    expect(@std_env[:/].call(2, 1)).to eq(2)
  end


  it 'can handle arrays correctly' do
    expect(@std_env[:length].call([1,2,3])).to eq(3)
  end

end
