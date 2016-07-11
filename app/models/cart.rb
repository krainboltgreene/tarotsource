class Cart < ActiveRecord::Base
  TAX_PERCENT = 0.0

  belongs_to :account
  has_many :items

  validates :account, presence: true
  validates :tax, presence: true
  validates :total, presence: true

  monetize :total_cents

  def tax_cents
    if super then super
    else
      assign_attribute(:tax_cents, (subtotals_cents - discount_cents || 0) * TAX_PERCENT)
    end
  end

  def subtotals_cents
    items.map(&:total_cents).sum
  end

  def total_cents
    if super then super
    else
      assign_attribute(:total_cents, (subtotals_cents - discount_cents || 0) + tax_cents)
    end
  end
end
