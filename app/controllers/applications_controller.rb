class ApplicationsController < ApplicationController
  include Response
  include ExceptionHandler
  before_action :set_application, only: [:show, :update, :destroy]

  # GET /applications
  def index
    @applications = current_user.applications
    json_response(@applications)
  end

  # POST /applications
  def create
    @application = current_user.applications.create!(application_params)
    json_response(@application, :created)
  end

  # GET /applications/:token
  def show
    json_response(@application)
  end

  # PUT /applications/:token
  def update
    @application.update(application_params)
    head :no_content
  end

  # DELETE /applications/:token
  def destroy
    @application.destroy
    head :no_content
  end

  private

  def application_params
    # whitelist params
    params.permit(:app_name)
  end

  def set_application
    @application = Application.where(token: params[:token]).take
  end
end
