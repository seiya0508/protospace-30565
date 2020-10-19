class PrototypesController < ApplicationController
  # ログインしていないユーザーがurlから編集や投稿ページへ遷移できないようにauthenticate_user!を用いて制限を設け,exceptオプションを用いて特定のアクションのみを指定
  before_action :authenticate_user!, except: [:index, :show]
  
  
  def index
    # インスタンス変数@prototypesを定義し、すべてのプロトタイプの情報を代入
    @prototypes = Prototype.all
  end

  # newアクションを定義
  def new
    # form_withに渡す引数として、値が空のPrototypeインスタンスを@prototypeに代入
    @prototype = Prototype.new
  end
  
  # createアクションを定義
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      # データが保存されたら新規投稿ページへ戻るようrenderを用いて記述
      redirect_to root_path
    else
      # データが保存されなかったときは新規投稿ページへ戻るようrenderを用いて記述
      render :new
    end
  end

 # showアクションを定義 詳細
  def show
    @prototype = Prototype.find(params[:id])
    #@commentというインスタンス変数を定義し、Commentモデルの新規オブジェクトを代入した
    @comment = Comment.new
    # show.html.erbに投稿に紐づくコメントおよびその投稿者を表示する記述
    @comments = @prototype.comments.includes(:user)
    

  end

  # 編集
  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user == current_user
      redirect_to action: :index
    end
  end
  # 更新
  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
       redirect_to prototype_path
    else
      render :edit
   end
  end
  # 削除
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end



  # ストロングパラメーターをセットし、特定の値のみを受け付けるようにした。且つ、user_idもmergeした
  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
