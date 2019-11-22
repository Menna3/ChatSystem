#class ApplicationChannel < ApplicationCable::Channel
#  def subscribed
#    application = Application.find params[:app_name]
#    stream_for application
#
#    # or
#    # stream_from "application#{params[:application]}"
#  end
#end