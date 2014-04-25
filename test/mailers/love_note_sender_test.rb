require 'test_helper'

class LoveNoteSenderTest < ActionMailer::TestCase
  test "send_text_message" do
    note = Note.new(message: 'Hi baby!')
    mail = LoveNoteSender.send_text_message(note)
    assert_equal 'Love Note', mail.subject
    assert_equal ["8593613596@vtext.com", "tkcrone@gmail.com", "8593611777@vtext.com", "twcrone@gmail.com"], mail.to
    assert_equal ["bigdaddy@ilovetheresacrone.com"], mail.from
    assert_match "Hi baby!", mail.body.encoded
  end

end
