class PrototypesController < ApplicationController
  before_action :move_to_index, only: [:edit]
  before_action :authenticate_user!, except: [:index, :show]
  # ↓prototypesコントローラーが読み込まれる時に最初に発動

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
     @prototype = Prototype.new(prototype_params)
     if @prototype.save
       redirect_to root_path
     else
       render :new
     end
  end

  def show
    @comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    # user_idの中から、今ログインしているuserを探すcurrent_user.id
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user_id
      # [ログインしているかチェック]＆[ログイン中のID]＝[この投稿作成者のID]
    redirect_to action: :index
    end
  end 

end
