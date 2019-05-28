class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @conversation = Conversation.find(params[:conversation_id])
    @message.conversation = @conversation
    @message.user = current_user
    if @message.save
      # ActionCable.server.broadcast("conversation_#{@conversation.id}", {
      #   message_partial: render(partial: "messages/message", locals: { message: @message, user_is_messages_author: false })
      # })
      respond_to do |f|
        f.html {redirect_to conversation_path(@conversation)}
        f.js
      end
    else
      respond_to do |f|
        f.html {render "conversations/show"}
        f.js
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
