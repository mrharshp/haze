class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_#{params[:conversation_id]}"
    # stream_from "some_channel"
  end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end
end
