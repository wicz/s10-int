require 'spec_helper'

describe Wikail do
  it "runs the dirty spike" do
    Wikail.process.should be(true)
  end
end