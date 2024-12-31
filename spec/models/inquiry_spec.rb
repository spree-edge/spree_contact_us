# frozen_string_literal: true

require 'spec_helper'

describe Spree::Inquiry, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:message) }
    it { should_not allow_value('test@test').for(:email) }
    it { should_not allow_value('testtest.dood.wtf').for(:email) }
    it { should allow_value('test@test.dood.wtf').for(:email) }
  end

  it { should have_db_column(:http_remote_addr) }
  it { should have_db_column(:http_user_agent) }
  it { should have_db_column(:client_viewport_size) }

  context 'saving an Inquiry,' do
    before do
    #   binding.pry
    #   Spree::MailMethod.stub(current: mock(preferred_mail_bcc: 'admin@example.com',
    #                                        preferred_mails_from: 'test@example.com',
    #                                        preferred_intercept_email: nil))
    end

    it 'sends the emails' do
      inquiry = Spree::Inquiry.new name: 'Zennike Jones', email: 'zennike@example.com', message: 'I do so like green eggs and ham!'
      inquiry.save
      binding.pry
      # sends a notification to admin and a confirmation to customer
      ActionMailer::Base.deliveries.collect(&:to).should == [['admin@example.com'], ['zennike@example.com']]
    end
  end
end
