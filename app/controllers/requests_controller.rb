class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new request_params
    if @request.valid?
      RequestMailer.request_invitation(@request).deliver_now
      redirect_to new_request_url, notice: "Request received, thanks! You should receive your invitation within 24 hours. If you don't see it, please check your email provider's spam or junk folder."
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :how_they_know)
  end
end