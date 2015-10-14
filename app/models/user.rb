class User < ActiveRecord::Base	
  before_save { self.email = email.downcase}								#将 email 转换为小写,确保邮件地址唯一
  validates :name, presence: true,  length: { maximum: 50 }	#存在性，不为空，长度限制
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  #正则表达式验证邮箱有效
  validates :email, presence: true,  length: { maximum: 255 },
  				     format: { with: VALID_EMAIL_REGEX },
  				     uniqueness: { case_sensitive: false }							#唯一性验证,不区分大小，自动指定 uniquenes:  true 
  has_secure_password																			#哈希加密
  validates :password, presence: true,  length: { minimum: 6 }
end
