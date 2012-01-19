require 'spec_helper'
require 'fileutils'

describe Wikail::FileEngine do
  let(:engine) { Wikail::FileEngine.new }

  before(:each) do
    filename = File.join Wikail::Environment::DATA_DIR, 'SGVsbG8gUk1VIQ=='
    File.open(filename, "w") { |file| file.puts "What's up doc!" }
  end

  after(:each) do
    FileUtils.rm_r Dir.glob("#{Wikail::Environment::DATA_DIR}/*")
  end

  describe "#list" do
    it "list documents" do
      engine.list.should include("Documents:\n\nHello RMU!")
    end
  end

  describe "#create" do
    it "creates a new document" do
      engine.create :args => "Untitled document", :body => "OHAI!"
      Dir.entries(Wikail::Environment::DATA_DIR).should include('VW50aXRsZWQgZG9jdW1lbnQ=')
      File.read(File.join(Wikail::Environment::DATA_DIR, 'VW50aXRsZWQgZG9jdW1lbnQ=')).should include "OHAI!"
    end
  end

  describe "#show" do
    it "shows the selected document" do
      doc = engine.show :args => "Hello RMU!"
      doc.should include("What's up doc!")
    end

    it "raises error if file not found" do
      expect { engine.show :args => "File not found!" }.to raise_error(Errno::ENOENT)
    end
  end
end