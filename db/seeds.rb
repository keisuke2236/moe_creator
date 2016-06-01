# coding: utf-8
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@users = []
@tags = []


@users[0] = ["てぃんくる","texinkuru"]
 @tags[0] = ["季節","ロリ"]
 
@users[1] = ["藤真拓哉","fujima"]
 @tags[1] = ["魔法少女","ロリ"]




for i in 0..@users.count-1 do
    @avatar = File.new(File.join(Rails.root, "app/assets/images/default_avatar/"+@users[i][1]+"_a.jpg"))
    @picture = File.new(File.join(Rails.root, "app/assets/images/default_picture/"+@users[i][1]+"_p.jpg"))
    @user = User.create(name: @users[i][0],email: @users[i][1]+'@gmail.com',avatar: @avatar,picture: @picture ,age: 1 ,password: "ko",creator: true)
    #binding.pry
    for i2 in 0..@tags[i].count-1
        
        if Tag.find_by(name: @tags[i][i2])!=nil
            @tag = Tag.find_by(name: @tags[i][i2])
        else
            @tag = Tag.create(:name => @tags[i][i2])
        end
        Draw.create(user_id: @user.id,tag_id: @tag.id)
    end
end