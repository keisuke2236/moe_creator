class TagsController < ApplicationController
  def show
    #binding.pry
  end

  def new
    #背景を入れたいので@userを定義
    @user = current_user
    @tag = Tag.new
    #binding.pry
    @tags = current_user.draw_tags
  end

  def create
    #Paramsの中から値を取得．sns_paramsでSns型に当てはまらない不要なデータ型を削除する
    #binding.pry
    @tag = Tag.find_by(name: params["tag"]["name"])
    @tag = Tag.new(sns_params) if @tag == nil
    if @tag.save
      current_user.draw_tags_add(@tag)
      #タグを保存できたらdraw_Tag中間テーブルにそのタグを登録した絵師のidとタグのidをひも付けておく
      flash[:success] = "#{@tag.name}を登録しました"
      redirect_to request.referer
    else
      flash[:success] = "#{@tag.name}のURLを登録できませんでした"
      redirect_to request.referer
    end
  end

  def destroy
    @del = Tag.find_by(id: params["del_id"])
    if current_user==nil
      flash[:success] = "この操作を行うためには再度ログインしてください"
      redirect_to root_path
    else
      current_user.draw_tags_del(@del)
      redirect_to request.referer
    end
  end

  def update
  end
  
  def sns_params
    params.require(:tag).permit(:name)
  end
end