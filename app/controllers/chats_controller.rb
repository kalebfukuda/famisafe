class ChatsController < ApplicationController
  def show

  end

  def index
    @chats = current_user.chats
    @chat = Chat.new
    render partial: "chats/list" if turbo_frame_request?
  end

  def create
  end
end
