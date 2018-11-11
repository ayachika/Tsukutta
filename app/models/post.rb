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
    has_many :post_tag_relations, dependent: :delete_all # 追加
    has_many :tags, through: :post_tag_relations  #追加
    belongs_to :user
    validates :user_id, presence: true
    default_scope -> { order(created_at: :desc) }
    # presence -> 必須チェック
    # length -> 文字数の制限
   # validates :name, presence: true, length: { maximum: 30 }
    validates :title, presence: true, length: { maximum: 30 }
    validates :content, presence: true, length: { maximum: 1000 }
    
    #画像のアップロード機能を持たせる
    mount_uploader :picture, PictureUploader
    validates :user, presence:true
    
    #favoriteモデル追加
    has_many :favorites, dependent: :destroy
    has_many :users, through: :favorites
    validates :user_id,presence: true
    validates :content, presence: true, length: { maximum: 140 }
    
end
