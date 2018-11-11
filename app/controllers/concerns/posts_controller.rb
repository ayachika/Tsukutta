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
         # Post モデルを引数のパラメータで初期化(データの保存は指定ない)
        post = Post.create(post_params)
        
        
         # フラッシュ
        # 保存の正否をチェック
   if post.save
      # フラッシュ
      flash[:notice] = "「#{post.title}」の記事が投稿されました!"
      redirect_to post
    else
    redirect_to new_post_path, flash: {
      post: post,
      error_messages: post.errors.full_messages
    }
   end
   #ユーザーと投稿を紐付けするときに追加
    
   
   
     end

    
    # findメソッドで、idにひもづくPOSTオブジェクトを取得する
    def show
     @post = Post.find_by(id: params[:id])
     # @comment = @post.comments.new
    
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
        comment = Comment.find(params[:id])
        @post.destroy
        
         # フラッシュ 
        flash[:notice] = "「#{@post.title}」の記事を削除しました!"
        
        # 投稿一覧へリダイレクト
        redirect_to posts_path
    end
    
    private
    
    #paramsから欲しいデータのみ抽出
    def post_params
        #params.require(:post).permit(:name, :title, :content)
        # tag_ids をリストで追加
        params.require(:post).permit(:name, :title, :content, tag_ids: [])
    end
    
    def set_target_post
        @post = Post.find(params[:id])
    end
    
end