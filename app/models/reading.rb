class Reading < ActiveRecord::Base
  belongs_to :account
  belongs_to :store
  has_many :order_items

  monetize :price_cents

  validates :name, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true
  validates :account, presence: true
  validates :store, presence: true
end
