class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc ) }		#按时间排序	
  mount_uploader :picture, PictureUploader			#图片上传
  validate :picture_size								#验证图片大小
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def picture_size
     if picture.size > 2.megabytes
       errors.add(:picture, "不能上传大于2MB的图片哦！")
     end
  end
  
end
