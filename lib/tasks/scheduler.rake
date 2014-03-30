def find_unsent_message_and_send
  puts "Sending love note..."
  note = Note.find_by sent_at: nil

  if note
    LoveNoteSender.send_text_message(note).deliver
    puts "Sending #{note.message}..."
    note.sent_at = DateTime.now
    puts "Saving sent at #{note.sent_at}..."
    note.save
  else
    puts 'No pending notes found.'
  end
end

desc "Send a love note"
task :send_love_note => :environment do
  num = rand(10)

  if num != 7
    puts "Number was #{num} and not 7.  Not sending love note."
  else
    find_unsent_message_and_send
  end

  puts "Done."
end