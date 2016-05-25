class Sns < ActiveRecord::Base
    #snsrerationsを複数持ち，snsrerationのsns_idからsnsのidで検索したものを持つ   snsrerations.find(sns.id) このsns.idは自動的にidが選定されて検索キーとして指定される railsの闇
    has_many :snsrerations , foreign_key: "sns_id", dependent: :destroy
    has_many :users, through: :snsrerations ,source: :user
end
