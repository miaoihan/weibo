class User < ActiveRecord::Base	
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",                          #主动关系映射
                                                           foreign_key: "follower_id",
                                                           dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",                       #被动关系映射
                                                           foreign_key: "followed_id",
                                                           dependent: :destroy                                                       
  has_many :following, through: :active_relationships, source: :followed         #  我关注的人              
  has_many :followers, through: :passive_relationships, source: :follower       #  关注我的人                 
  attr_accessor :remember_token                                                                           #  记忆令牌
  before_save { self.email = email.downcase}				                            #将 email 转换为小写,确保邮件地址唯一
  validates :name, presence: true,  length: { maximum: 50, minimum: 4 }	#存在性、不为空，长度限制
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 	#正则表达式验证邮箱有效性
  validates :email, presence: true,  length: { maximum: 255 },
  				     format: { with: VALID_EMAIL_REGEX },
  				     uniqueness: { case_sensitive: false }		                            #唯一性验证,不区分大小，自动指定 uniquenes:  true 
  has_secure_password									    	                            #哈希加密
  validates :password, presence: true,  length: { minimum: 6 },  allow_nil: true
  
  # 实现动态流原型
  def feed
    #Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
    #下面啥SQL子查询，优化搜索性能
    following_ids = "SELECT followed_id FROM relationships
                                WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  # 关注另一个用户
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # 取消关注另一个用户
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 如果当前用户关注了指定的用户,返回 true
  def following?(other_user)
    following.include?(other_user)
  end

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
