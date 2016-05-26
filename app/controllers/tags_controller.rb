class TagsController < ApplicationController
  def show
    
  end

  def new
    binding.pry
    @tag = Tag.new
  end

  def create
    binding.pry
    #Paramsの中から値を取得．sns_paramsでSns型に当てはまらない不要なデータ型を削除する
    @tag = Tag.new(sns_params)
    @tags.user_id = current_user.id
    if @sns.save
      flash[:success] = "#{@sns.name}のURLを登録しました！"
      redirect_to :action => "edit", :id => current_user.id
    else
      flash[:success] = "#{@sns.name}のURLを登録できませんでした"
      redirect_to :action => "edit", :id => current_user.id
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
