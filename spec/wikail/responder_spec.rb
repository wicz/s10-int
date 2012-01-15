require 'spec_helper'

describe Wikail::Responder do

  let(:responder) { Wikail::Responder.new }

  before(:each) do
    Mail::TestMailer.deliveries.clear
  end

  it "default transport is Mail" do
    responder.transport.should be(Mail)
  end

  it "respond email" do
    message = Mail.new { from 'rmu@localhost' }
    responder.respond message, 'content'
    sent = Mail::TestMailer.deliveries.first
    sent.to.should eq(message.from)
    sent.from.first.should eq(Wikail.config.from_address)
    sent.body.should eq('content')
  end
end