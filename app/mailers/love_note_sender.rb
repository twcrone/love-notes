class LoveNoteSender < ActionMailer::Base
  default from: "bigdaddy@ilovetheresacrone.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.love_note_sender.send_text_message.subject
  #
  def send_text_message(note)
    @greeting = note.message

    mail to: '8593613596@vtext.com, tkcrone@gmail.com, 8593611777@vtext.com, twcrone@gmail.com', subject: 'Love Note'
  end
end
