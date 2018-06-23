class RequestsController < ApplicationController
  before_action :require_user_logged_in
  require 'date'
  
  def index
    @requests = Request.all.order('created_at DESC').page(params[:page])
    # @requests.where(status: "hoge")
    # @requests = current_user.requests.order('created_at DESC').page(params[:page])
  end

  def show
    @request = Request.find(params[:id])
    @user = User.find(@request.user)
  end

  def new
    @request = Request.new(user_id: current_user.id,limit_date: Date.today+7,status: 0)
  end

  def update
    @request = Request.find(params[:id])
    @request.charge_user = params[:charge_user_id] if params[:charge_user_id]
    @request.status = params[:status] if params[:status]

    if params[:charge_user_id] && @request.save
      flash[:success] = 'request は正常に更新されました'
       redirect_back(fallback_location: root_url)
    elsif @request.update(request_params)
      flash[:success] = 'request は正常に更新されました'
      redirect_to @request
    else
      flash.now[:danger] = 'request は更新されませんでした'
      render :edit
    end
  end

  def edit
    @request = Request.find(params[:id])
    @user = User.find(@request.user)
  end

  def create
    # @request = Request.new(request_params)

  @request = current_user.requests.build(request_params)

    if @request.save
      flash[:success] = 'メッセージを投稿しました。'
      # redirect_to @request
      redirect_to root_path
    else
      @requests = current_user.requests.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end    
    
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    flash[:success] = 'request は正常に削除されました'
    redirect_to root_url

  end

  private

  # Strong Parameter
  def request_params
    params.require(:request).permit(:title,:limit_date,:description,:status,:charge_user)
  end
end
