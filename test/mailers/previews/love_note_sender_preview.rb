# Preview all emails at http://localhost:3000/rails/mailers/love_note_sender
class LoveNoteSenderPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/love_note_sender/send_text_message
  def send_text_message
    LoveNoteSender.send_text_message
  end

end
