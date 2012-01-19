require 'spec_helper'

describe Wikail::Responder do

  let(:responder) { Wikail::Responder.new }

  # before(:each) do
  #   Mail::TestMailer.deliveries.clear
  # end

  it "default transport is Mail" do
    responder.transport.should be_a(Wikail::MailTransport)
  end

  it "respond email" do
    args = %w{ rmu@localhost subject content }
    responder.transport.should_receive(:deliver).with(*args)
    responder.respond *args
  end
end