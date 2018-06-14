class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @request = current_user.requests.build  # form_for 用
      @requests = current_user.requests.order('created_at DESC').page(params[:page])
    end
  end
end
