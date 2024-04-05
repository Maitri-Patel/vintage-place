class Product < ApplicationRecord
  belongs_to :category
  validates :category, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "price", "quantity_available", "category_id", "created_at", "updated_at"]
  end
  
  # Allowlists associations that can be searched through Ransack
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  # Assuming you have a boolean column `on_sale` to indicate if the product is on sale
  scope :on_sale, -> { where(on_sale: true) }

  # Assuming you consider "new" products as those created within the last 7 days
  scope :new_products, -> { where('created_at >= ?', 7.days.ago) }

  # For recently updated products, assuming updated within the last 1 days
  scope :recently_updated, -> { where('updated_at >= ?', 1.days.ago) }
  
end
