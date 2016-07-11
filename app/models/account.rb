class Account < ActiveRecord::Base
  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :validatable

  has_one :store
  has_many :carts

  validates :name, presence: true
end
