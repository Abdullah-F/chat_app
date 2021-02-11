range = (1..5)

def create_messages(range, chat)
  range.each do |message_number|
    Message.create(
      chat: chat,
      order: message_number,
      body: "Subject#{chat.subject.id}|Chat#{chat.id}|Message#{message_number}")
  end
end

def create_chats(range, subject)
  range.each do |chat_number|
    Chat.create(subject: subject, order: chat_number).tap do |chat|
      create_messages(range, chat)
    end
  end
end


range.each do |subject_number|
  Subject.create(name: "Subject Number #{subject_number}").tap do |subject|
    create_chats(range, subject)
  end
end

