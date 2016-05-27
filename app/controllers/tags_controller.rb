class TagsController < ApplicationController
  def show
    
  end

  def new
    @tag = Tag.new
    @tags = DrawTag.where(user_id: current_user.id)
  end

  def create
    binding.pry
    #Paramsの中から値を取得．sns_paramsでSns型に当てはまらない不要なデータ型を削除する
    
    @tag = Tag.new(sns_params)
    if @tag.save
      #タグを保存できたらdraw_Tag中間テーブルにそのタグを登録した絵師のidとタグのidをひも付けておく
      @draw = DrawTag.new
      @draw.user_id = current_user.id
      @draw.tag_id = @tag.id
      if @draw.save
        flash[:success] = "#{@tag.name}を登録しました"
        redirect_to request.referer
      else
        flash[:success] = "#{@tag.name}の絵師登録ができませんでした"
        redirect_to request.referer
      end
    else
      flash[:success] = "#{@tag.name}のURLを登録できませんでした"
      redirect_to request.referer
    end
  end

  def destroy
  end

  def update
  end
  
  def sns_params
    params.require(:tag).permit(:name)
  end
end
