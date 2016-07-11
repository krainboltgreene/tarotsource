class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :subject, polymorphic: true

  validates :cart, presence: true
  validates :subject, presence: true

  monetize :price_cents
  monetize :total_cents

  def price_cents
    if super then super
    else assign_attribute(:price_cents, (subtotals_cents - discount_cents || 0) * TAX_PERCENT)
    end
  end

  def total_cents
    if super then super
    else
      assign_attribute(:total_cents, (subtotals_cents - discount_cents || 0) * TAX_PERCENT)
    end
  end
end
