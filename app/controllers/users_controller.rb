class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    
    
    # モデルクラスのwhereメソッドへ検索カラムと値を渡すと合致するモデルを配列形式で返却
    #@posts = Post.where(:user_id, @user.id)
  end

  def new
    @user = User.new
  end
  
  def create
    
    @user = User.new(user_params)   
    if @user.save
      log_in @user
      # 保存の成功をここで扱う。
      flash[:success] = "Tsukutta!へようこそ"
      redirect_to @user
    else
      flash[:error_messages] = @user.errors.full_messages
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
end