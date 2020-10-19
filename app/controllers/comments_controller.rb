class CommentsController < ApplicationController

# createアクションを定義
  def create
    
    @comment = Comment.new(comment_params)    
    if @comment.save
      # データが保存されたら詳細ページへ戻るようrenderを用いて記述
      redirect_to prototype_path(@comment.prototype)
    
    else
      # データが保存されなかったときは詳細ページへ戻るようrenderを用いて記述
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show" # views/prototypess/show.html.erbのファイルを参照しています。
    end
  end
  

    # privateメソッドにストロングパラメーターをセットし、特定の値のみを受け付けるようにした。且つ、user_idとprototype_idもmergeした
    private
    def comment_params
      params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    end
  end
