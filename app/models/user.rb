class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipe_foods, through: :recipes

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
