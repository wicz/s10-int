require 'spec_helper'
require 'fileutils'

describe Wikail::FileEngine do
  let(:engine) { Wikail::FileEngine.new }

  describe "#list" do
    it "list documents" do
      FileUtils.touch Wikail.config.data_dir + '/SGVsbG8gUk1VIQ=='
      engine.list.should include("Documents:\nHello RMU!")
    end
  end

  describe "#new" do
    it "creates a new document" do
      engine.create :args => "Untitled document", :body => "OHAI!"
      Dir.entries(Wikail.config.data_dir).should include('VW50aXRsZWQgZG9jdW1lbnQ=')
      File.read(File.join(Wikail.config.data_dir, 'VW50aXRsZWQgZG9jdW1lbnQ=')).should include "OHAI!"
      FileUtils.rm_r Dir.glob("#{Wikail.config.data_dir}/*")
    end
  end
end