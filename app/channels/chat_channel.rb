#class ChatChannel < ApplicationCable::Channel
#  def subscribed
#    chat = Chat.find params[:chat_name]
#    stream_for chat
#
#    # or
#    # stream_from "chat#{params[:chat]}"
#  end
#end