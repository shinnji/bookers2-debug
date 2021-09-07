class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments
  # フォローする側から中間テーブルへのアソシエーション
  has_many :relationships, foreign_key: :following_id
  # フォローする側からフォローされたユーザを取得する
  has_many :followings, through: :relationships, source: :follower

  # フォローされる側から中間テーブルへのアソシエーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
 # フォローされる側からフォローしているユーザを取得する
  has_many :followers, through: :reverse_of_relationships, source: :following
  attachment :profile_image, destroy: false
  validates :introduction, {length: {maximum: 50}}
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  def already_favorited?(book)
    self.favorites.exists?(book_id: book)
  end
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end
end
