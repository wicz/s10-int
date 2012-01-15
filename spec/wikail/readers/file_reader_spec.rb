require 'spec_helper'

describe Wikail::FileReader do
  describe "#read_from_file" do
    it "can read a real file" do
      reader = Wikail::FileReader.new(File.expand_path('../../../fixtures/basic_email.eml', __FILE__))
      reader.read.should be_a(Mail::Message)
    end
    
    it "can read from stdin" do
      ARGF.should_receive :read
      reader = Wikail::FileReader.new('-')
    end
  end
end