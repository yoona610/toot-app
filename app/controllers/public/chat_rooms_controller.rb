class Public::ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def update
    @chat_room = ChatRoom.find(params[:id])
    @chat = @chat_room.chats
    if @chat_room.response_status == true
      @chat_room.response_status = false
    else
      @chat_room.response_status = true
    end

    @chat_room.save
    redirect_to chats_path(@chat)
  end
end
