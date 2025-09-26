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
      prompt = <<-PROMPT
        You are a precise disaster predictor and only knows about this.
        The user will ask about natural disasters in Japan, looking for solutions,
        ways of getting prepared and how to act if something happens, using simple and practical terms.
        Answer the question "#{@message.content}".
        Your output must be formatted as HTML.
      PROMPT

      response = RubyLLM.chat.ask(prompt)
      msg_ai = Message.new
      msg_ai.content = response.content
      msg_ai.role = "AI"
      msg_ai.chat_id = @chat.id
      msg_ai.save

      @messages = @chat.messages.order(created_at: :asc)
      @message = Message.new
      respond_to do |format|
        format.turbo_stream
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
