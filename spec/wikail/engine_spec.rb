require 'spec_helper'

describe Wikail::Engine do

  let(:engine) { Wikail::Engine.new }

  describe "#new" do
    it "default engine is file" do
      engine.engine.should be_a(Wikail::FileEngine)
    end

    it "can initialize with another engine" do
      CrazyEngine = Class.new
      engine = Wikail::Engine.new(CrazyEngine.new)
      engine.engine.should be_a(CrazyEngine)
    end
  end

  describe "#execute" do
    it "delegate command to engine" do
      options = {:args => 'title', :body => 'body'}
      engine.engine.should_receive('command').with(options)
      engine.execute ':command', options
    end
  end

  describe "#title_to_filename" do
    it "encode base64" do
      engine.title_to_filename('Hello RMU!').should eq('SGVsbG8gUk1VIQ==')
    end
  end

  describe "#filename_to_title" do
    it "decode base64" do
      engine.filename_to_title('SGVsbG8gUk1VIQ==').should eq('Hello RMU!')
    end
  end
end