require 'test_helper'

class LoveNoteSenderTest < ActionMailer::TestCase
  test "send_text_message" do
    mail = LoveNoteSender.send_text_message
    assert_equal "Send text message", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
