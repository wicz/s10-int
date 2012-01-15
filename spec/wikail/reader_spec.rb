require 'spec_helper'

describe Wikail::Reader do
  describe "#new" do
    it "can read from file" do
      reader = Wikail::Reader.new(:file, __FILE__)
      reader.adapter.should be_a(Wikail::FileReader)
    end
    
    it "can read from a profile" do
      reader = Wikail::Reader.new(:profile, 'gmail')
      reader.adapter.should be_a(Wikail::ProfileReader)
    end
    
    it "can't read from elsewhere" do
      expect { Wikail::Reader.new(:mind, 'Vinicius') }.to raise_error NameError
    end
  end
end