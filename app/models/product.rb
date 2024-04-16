class Product < ApplicationRecord
  belongs_to :category
  validates :category, presence: true
  has_many :order_tracks
  has_many :orders, through: :order_tracks

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity_available, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "price", "quantity_available", "category_id", "created_at", "updated_at"]
  end
  
  # Allowlists associations that can be searched through Ransack
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  # Assuming you have a boolean column `on_sale` to indicate if the product is on sale
  scope :on_sale, -> { where(on_sale: true) }

  # Assuming you consider "new" products as those created within the last 3 days
  scope :new_products, -> { where('created_at >= ?', 10.days.ago) }

  # For recently updated products, assuming updated within the last 1 days
  #scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago) }
  
end
