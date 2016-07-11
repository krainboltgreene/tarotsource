class Store < ActiveRecord::Base
  belongs_to :account
  has_many :readings

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :account, presence: true
end
