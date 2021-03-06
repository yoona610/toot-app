class Public::ChatsController < ApplicationController
  before_action :authenticate_user!

  def show
    user_chat_room = current_user.chat_room
    @chat_room = nil
    @chat_room = if user_chat_room.nil?
                   ChatRoom.create(user_id: current_user.id)
                 else
                   user_chat_room
                 end
    @chats = @chat_room.chats
    @chat = Chat.new(chat_room_id: @chat_room.id)
  end

  def create
    @chat = current_user.chats.create(chat_params)
    @chats = @chat.chat_room.chats
    @chat.chat_room.update(response_status: false)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id, :is_admin)
  end
end
