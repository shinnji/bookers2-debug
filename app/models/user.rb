class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false
  validates :introduction, {length: {maximum: 50}}
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  def already_favorited?(book)
    self.favorites.exists?(book_id: book)
  end
end
