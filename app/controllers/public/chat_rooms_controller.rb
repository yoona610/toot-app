class Public::ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def update
    @chat_room = ChatRoom.find(params[:id])
    @chat = @chat_room.chats
    @chat_room.update(response_status: true)
  end
end
