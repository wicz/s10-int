require 'spec_helper'

describe Wikail::Parser do

  let(:parser) { Wikail::Parser.new }
  let(:email) { Mail.read(File.expand_path('../../fixtures/basic_email.eml', __FILE__)) }
  let(:invalid_email) { Mail.read(File.expand_path('../../fixtures/invalid_email.eml', __FILE__)) }
  
  describe "#tokenize" do
    it "invalid email scan empty tokens" do
      message = Mail.new
      tokens = parser.tokenize(message)
      tokens.should be_empty
    end
    
    it "scan command w/o args and body" do
      message = Mail.new { body ":list" }
      tokens = parser.tokenize(message)
      tokens[0].should eq(":list")
    end
    
    it "scan command and title" do
      message = Mail.new { body ":new Hello World"}
      tokens = parser.tokenize message
      tokens[0].should eq(":new")
      tokens[1].should eq("Hello World")
    end
    
    it "scan command, title and body" do
      message = Mail.new { body ":new Hello\nRMU"}
      tokens = parser.tokenize message
      tokens[0].should eq(":new")
      tokens[1].should eq("Hello")
      tokens[2].should eq("RMU")
    end
    
    it "scan optional :end" do
      message = Mail.new { body ":new Hello\nRMU\n:end\n-vinicius"}
      tokens = parser.tokenize message
      tokens[0].should eq(":new")
      tokens[1].should eq("Hello")
      tokens[2].should eq("RMU")
    end
  end
  
  describe "#parse" do
    it "raise error email w/o command" do
      message = Mail.new
      expect { parser.parse(message) }.to raise_error(Wikail::Parser::InvalidEmailSyntax)
    end
    
    it "normalizes tokens" do
      message = Mail.new { body ':list'}
      parser.parse(email).should eq({:command => ':list', :args => nil, :body => nil})
    end
  end
  
end