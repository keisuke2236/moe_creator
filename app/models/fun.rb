class Fun < ActiveRecord::Base
    before_save{ self.email = self.email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    
end
