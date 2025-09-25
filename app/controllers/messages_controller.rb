class MessagesController < ApplicationController
  def index
    @chat = Chat.find(params[:chat_id])
    @messages = @chat.messages.order(created_at: :asc)
    @message = Message.new
    respond_to do |format|
      format.html { render partial: "chats/messages", locals: { messages: @messages } } # Renderiza a partial
    end
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build(params_messages)

    if @message.save
      respond_to do |format|
        format.turbo_stream # renderiza automaticamente create.turbo_stream.erb
        format.html { redirect_to @chat }
      end
    else
      render :new
    end
  end

  private

  def params_messages
    params.require(:message).permit(:content, :role, :chat_id)
  end
end
