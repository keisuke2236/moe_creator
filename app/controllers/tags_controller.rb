class TagsController < ApplicationController
  def show
    if params["id"] != nil
      @tag = Tag.find_by(id: params["id"])
      @user = @tag.draw_users
      @map = Hash.new
      @user.each do |user|
        @map[user] = user.follower_users.count
      end
      @user = @map.sort_by{ |_, v| -v }
      
      @users = []
      i = 0
      @user.each do |user|
        @users[i] = @user[i][0]
        i = i + 1
      end
      
    else
      #特にid指定がない場合はフォロワーが多いタグから順番に表示する
      #タグidが指定されている場合はそのタグを登録している絵師さんを人気順に30こ表示する
      @rank = Tag.all
      @map = Hash.new
      @rank.each do |tag|
        @map[tag.id] = tag.draw_users.count
      end
      @tags = @map.sort_by{ |_, v| -v }
    end
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
      flash[:success] = "#{@tag.name}　15文字いないで入力してください"
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