# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  name       :string
#  picture    :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Post < ApplicationRecord
    #Commentモデルを複数持てる様にする
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :delete_all
    has_many :post_tag_relations, dependent: :delete_all, foreign_key: 'post_id'
    has_many :tags, through: :post_tag_relations  #追加
    belongs_to :user
    validates :user_id, presence: true
    default_scope -> { order(created_at: :desc) }
    # presence -> 必須チェック
    # length -> 文字数の制限
    # validates :name, presence: true, length: { maximum: 30 }
    validates :title, presence: true, length: { maximum: 30 }
    validates :content, presence: true, length: { maximum: 1000 }
    validate  :picture_size
    
    #画像のアップロード機能を持たせる
    mount_uploader :picture, PictureUploader
    validates :user, presence:true
    
    #favoriteモデル追加
    has_many :favorites, dependent: :destroy
    has_many :users, through: :favorites
    validates :user_id,presence: true
    validates :content, presence: true, length: { maximum: 140 }
    
    private
    
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
    
    
end
