# Applicationcontrollerクラスを継承することで、クラスがコントローラと認識される
class PostsController < ApplicationController
    def index
        # 追加
        # タグが選択されている場合は、タグに関連されているデータを取得、そうでなければ全てのデータを取得(ただし、データの全検索はしてない)
        @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    
        # page メソッドを呼ぶと引数に指定したページに表示するデータ分だけ取得(デフォルトは、25件)
        @posts = Post.page(params[:page])
        
    end
    
    #ルーティングの変更後に追加
    def new
        @post = Post.new(flash[:board])
    end
    
     def create
        @post = Post.new(post_params)
        @post.user = current_user
         
         # Post モデルを引数のパラメータで初期化(データの保存は指定ない)
        @Post = Post.new(
            content: params[:content],user_id: @current_user.id )
        
        # 保存の正否をチェック
   if @post.save
      redirect_to @post
    else
    redirect_to new_post_path, flash: {
      post: @post,
      error_messages: @post.errors.full_messages
    }
   end
     end

    
    # findメソッドで、idにひもづくPOSTオブジェクトを取得する
    def show
        @post = Post.find(params[:id]) 
        @comment = Comment.new(post_id: @post.id)
    
    end
    
    # 追加
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        post = Post.find(params[:id])
        # モデルの更新は、クラスメソッドのupdateメソッドで行える
        post.update(post_params)
        
        # フラッシュ
        flash[:notice] = "「#{@post.title}」の記事を更新しました!"
        
        # リダイレクト処理
        redirect_to @post
    end
    
    # 削除機能
    def destroy
        
        @post = Post.find(params[:id])
        @post.delete
        
         # フラッシュ 
        flash[:notice] = "「#{@post.title}」の記事を削除しました!"
        
        # 投稿一覧へリダイレクト
        redirect_to posts_path
    end
    
    private
    
    #paramsから欲しいデータのみ抽出
    def post_params
        params.require(:post).permit(:title, :content, :picture, tag_ids: [])
    end
    
    def set_target_post
        @post = Post.find(params[:id])
    end
    
    def ensure_correct_user
    @post = Post.find_by(id:params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
    end
end