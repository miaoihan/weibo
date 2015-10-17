class User < ActiveRecord::Base	
  attr_accessor :remember_token
  before_save { self.email = email.downcase}				#将 email 转换为小写,确保邮件地址唯一
  validates :name, presence: true,  length: { maximum: 50, minimum: 4 }	#存在性、不为空，长度限制
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 	#正则表达式验证邮箱有效性
  validates :email, presence: true,  length: { maximum: 255 },
  				     format: { with: VALID_EMAIL_REGEX },
  				     uniqueness: { case_sensitive: false }		#唯一性验证,不区分大小，自动指定 uniquenes:  true 
  has_secure_password									    	#哈希加密
  validates :password, presence: true,  length: { minimum: 6 },  allow_nil: true

  # 返回指定字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  # 返回一个随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 为了持久会话,在数据库中记住用户
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  # 如果指定的令牌和摘要匹配,返回 true
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # 忘记用户
  def forget
    update_attribute(:remember_digest, nil)
  end
end
