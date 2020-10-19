class Prototype < ApplicationRecord

  belongs_to :user  # usersテーブルとのアソシエーション
  has_many :comments # commentsテーブルとのアソシエーション
  has_one_attached :image # Active Storageのテーブルで管理された画像ファイルのアソシエーションを記述
  has_many :comments, dependent: :destroy
  # プロトタイプの名称、キャッチコピー、コンセプト、画像に関するバリデーションを記述した
  validates :image, presence: true
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  
end
