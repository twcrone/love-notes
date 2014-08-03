def find_unsent_message_and_send
  puts "Sending love note..."
  notes = Note.where('sent_at IS NULL')
  count = notes.length
  puts "Found #{count} unsent notes..."
  index = rand(count)
  puts "Picking note at index=#{index}"
  note = notes[index]
  if note
    puts "Sending note #{note.id}"
    LoveNoteSender.send_text_message(note).deliver
    puts "Sending #{note.message}..."
    note.sent_at = DateTime.now
    puts "Saving sent at #{note.sent_at}..."
    note.save
  else
    puts 'No pending notes found.'
    send_oldest_sent_message
  end
end

def send_oldest_sent_message
  puts "Sending old love note..."
  note = Note.where('sent_at IS NOT NULL').order('sent_at ASC').first
  LoveNoteSender.send_text_message(note).deliver
  puts "Sending #{note.message}...sent on #{note.sent_at}"
  note.sent_at = DateTime.now
  puts "Saving sent at #{note.sent_at}..."
  note.save
end

desc "Send a love note"
task :send_love_note => :environment do
  num = rand(25)

  if num == 17
    find_unsent_message_and_send
  elsif num == 12 || num == 10
    puts 'Sending an old note'
    send_oldest_sent_message
  else
    puts "Number was #{num}.  Not sending love note."
  end

  puts "Done."
end

desc "Send a old note"
task :send_old_love_note => :environment do
  send_oldest_sent_message
end

desc "Force send a love note"
task :force_send_love_note => :environment do
  find_unsent_message_and_send
  puts "Done."
end
